_REMOTE_CONTAINER_BUILD = """
package(default_visibility = ["//visibility:public"])

exports_files(["image.tar"])
"""

def _remote_container_image_impl(ctx):
    output = "image.tar"
    download_info = ctx.download(
        url = ctx.attr.urls,
        output = output,
        sha256 = ctx.attr.sha256,
    )
    ctx.file("WORKSPACE", 'workspace(name = "{name}")'.format(name = ctx.name))
    ctx.file("BUILD", _REMOTE_CONTAINER_BUILD)

_remote_container_image_attrs = {
    "urls": attr.string_list(
        mandatory = True,
        doc = "A list of URLs to fetch the tar file from"
    ),
    "sha256": attr.string(doc = "The expected SHA-256 of the downloaded file.")
}

remote_container_image = repository_rule(
    implementation = _remote_container_image_impl,
    attrs = _remote_container_image_attrs,
    doc = """Downloads a tar file from a URL and creates a container_image.

Useful to avoid having to login to GCP to download the distroless images. We
store the distroless images in a public storage bucket.
""",
)
