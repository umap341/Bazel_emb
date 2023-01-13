# load("","stlink_binary1", "reset")
load('//tools/flash:rules.bzl', 'flash_tool')
# Target overview
cc_binary(
  name = "application",
  srcs = glob(["*.c"]),
  deps = [
    "//examples/algorithm",
    "//platforms/mcu:microcontroller",
  ],
  visibility = ["//visibility:public"],
)

genrule(
  name = "app",
  srcs = [":application"],
  outs = ["app.hex"],
  cmd = "objcopy -O ihex $(location :application) $(location :app.hex)" ,
  visibility = ["//visibility:public"],
)

# genrule(
#   name = "file",
#   srcs = [":app"],
#   outs = ["file.elf"],
#   cmd = "mv $(location :app) $@",
#   visibility = ["//visibility:public"]
# )

# flash(
#     name = "flash",
#     # srcs = ":application",
#     # flash_offset = "0x8000000",
#     # transport = "SWD",
#     # device_sn = select({
#     #     "stm32f407IG": "066DFF505252836687125942",
#     # }),
#     # deps = [":hex_file"],
#     visibility = ["//visibility:public"],
# )


# flash_tool(
#     name='foo',
# )

# genrule(
#     name='bar',
#     tools=['//tools/flash'],
#     outs=['bar.txt'],
#     cmd="$(location //tools/flash) $@",
#     executable = True

# )

# load("//foo:bind.bzl", "bind_foo")

# bind_foo(
#     name = "bar",
#     args = [
#         "$(location first_file)",
#         "$(location second_file)",
#     ],
#     data = [
#         ":first_file",
#         ":second_file",
#     ],
# )

# sh_binary(
#   name = "run",
#   srcs = ["//tools/Run:st-link-flash"],
#   visibility = ["//visibility:public"],
# )
