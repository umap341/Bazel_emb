# """deps.bzl"""

# load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# def arm_none_eabi_deps():
#     """Workspace dependencies for the arm none eabi gcc toolchain"""

#     http_archive(
#         name = "arm_none_eabi_linux_x86_64",
#         build_file = "@arm_none_eabi//toolchain:compiler.BUILD",
#         sha256 = "bcd840f839d5bf49279638e9f67890b2ef3a7c9c7a9b25271e83ec4ff41d177a",
#         strip_prefix = "gcc-arm-none-eabi-9-2019-q4-major",
#         url = "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2?revision=108bd959-44bd-4619-9c19-26187abf5225&la=en&hash=E788CE92E5DFD64B2A8C246BBA91A249CB8E2D2D",
#     )

#     # http_archive(
#     #     name = "arm_none_eabi_linux_aarch64",
#     #     build_file = "@arm_none_eabi//toolchain:compiler.BUILD",
#     #     sha256 = "1f5b9309006737950b2218250e6bb392e2d68d4f1a764fe66be96e2a78888d83",
#     #     strip_prefix = "gcc-arm-none-eabi-9-2019-q4-major",
#     #     url = "https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-aarch64-linux.tar.bz2?revision=4583ce78-e7e7-459a-ad9f-bff8e94839f1&la=en&hash=550DB9C0184B7C70B6C020A5DCBB9D1E156264B7",
#     # )

#     http_archive(
#         name = "arm_none_eabi_windows_x86_32",
#         build_file = "@arm_none_eabi//toolchain:compiler.BUILD",
#         sha256 = "e4c964add8d0fdcc6b14f323e277a0946456082a84a1cc560da265b357762b62",
#         url = "https://case.artifacts.medtronic.com:443/artifactory/pump_sw_rnd-generic-dev-local/pump_sw_rnd/devops/bazel/gcc-arm-none-eabi-10.3-2021.10-win32.zip",
#     )

#     native.register_toolchains(
#         "@arm_none_eabi//toolchain:linux_x86_64",
#         # "@arm_none_eabi//toolchain:linux_aarch64",
#         "@arm_none_eabi//toolchain:windows_x86_32",
#         "@arm_none_eabi//toolchain:windows_x86_64",
#     )
