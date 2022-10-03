py_binary(
  name = "deploy",
  # srcs = glob(["*.py"]),
  # main = "main.py", 
  srcs = ["deploy.py"],
#   args = ["$(location //examples/application:application)",]
#   data = ["//examples/application"],
  visibility = ["//visibility:public"],
)

flash_execution_wrapper(
    name = "test_wrapper",
    device_type = "stm32f407xx",
    file_path = "C:/Users/patilu3/Bazel_Projects/bazel-build-sample/bazel-bin/examples/application/app.hex",
)

