I can't figure out how to use an external tar file as a docker image.


To reproduce:

```shell script
go get github.com/wagoodman/dive
bazel run :static_image

# Output
Loaded image ID: sha256:12e0635b4f21ae7d09330f99ef6381ab7b33f5305c8852ca4bd79959da41af13
Tagging 12e0635b4f21ae7d09330f99ef6381ab7b33f5305c8852ca4bd79959da41af13 as bazel:static_image

# Explore file system and see that the tar file is included directly.
dive 12e0635b4f21ae7d09330f99ef6381ab7b33f5305c8852ca4bd79959da41af13
```
