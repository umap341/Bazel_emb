workspace(name = "build")

register_toolchains("//platforms/compiler:all")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
    ],
    sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
)

# http_archive(
#     name = "arm_none_eabi",
#     sha256 = "3d3728cbe88b08c12cd2cb89afcff9294bd77be958c78188db77fdc8ab7e7a5d",
#     strip_prefix = "bazel-arm-none-eabi-1.1",
#     url = "https://github.com/d-asnaghi/bazel-arm-none-eabi/archive/v1.1.tar.gz",
# )

# load("@arm_none_eabi//:deps.bzl", "arm_none_eabi_deps")
# arm_none_eabi_deps()

# Load the Python workspace rule.
#load("//third_party/python:python.bzl", "local_python")

# The Python C library is used to create extensions modules. The Python
# installation is automatically configured using the given executable.
#local_python(
#  name = "local_python",
#  executable_name = "python")
