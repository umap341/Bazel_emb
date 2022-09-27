# Provides the tool.

load('//tools/flash:rules.bzl', 'flash_tool')

genrule(
  name = "app",
  srcs = ["//examples/application"],
  outs = ["app.hex"],
  cmd = "objcopy -O ihex $(location //examples/application) $(location :app.hex)" ,
  visibility = ["//visibility:public"],
)

py_binary(
  name = "flash",
  srcs = glob(["*.py"]),
  main = "main.py", 
#   args = ["$(location //examples/application:application)",]
  data = [":app"],
  visibility = ["//visibility:public"],
)

# flash_tool(
#     name = "run",
#     args = [
#         "stm32f407xx",
#         # "$(location :app)",
#         "C:/Users/patilu3/Bazel_Projects/bazel-build-sample/bazel-bin/tools/flash/app.hex"
#     ],
#     data = [
#         ":app",
#     ],
# )

flash_tool(
    name = "run",
    # args = [
    #     "stm32f407xx",
    #     # "$(location :app)",
    #     "C:/Users/patilu3/Bazel_Projects/bazel-build-sample/bazel-bin/tools/flash/app.hex"
    # ],
    # data = [
    #     ":app",
    # ],
    outfile = "run.txt"
)

# sh_binary(
# 	name='simple-runner',
# 	srcs=['simple-runner.sh'],
# 	data=['simple'],
# )
