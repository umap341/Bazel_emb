# def _impl(ctx):
#     ctx.actions.run(
#         executable = ctx.executable._flash,
#         arguments = [ctx.outputs.text.path],
#         outputs = [ctx.outputs.text],
#     )

# flash_tool = rule(
#     implementation = _impl,
#     attrs = {
#         "_flash": attr.label(executable=True, allow_files=True, cfg = "exec", default=Label("//tools/flash:flash"))
#     },
#     outputs = {
#         "text": "%{name}.txt",
#     },
#     executable =True
# )

# load("@bazel_skylib//rules:copy_file.bzl", "copy_file")
# def flash_tool(name, **kwargs):
#     copy_file(
#         name = "%s.py.create" % name,
#         src = "//tools/flash:main.py",
#         out = "%s.py" % name, # Appease local main search
#     ) # Why is no copy_file action provided by Skylark???

#     native.py_binary(
#         name = name,
#         srcs = [
#             "%s.py" % name,
#         ],
#         deps = [
#             "//tools/flash:flash",
#         ],
#         **kwargs
#     )

def _stuff_rule_impl(ctx):
    ctx.actions.run(
        inputs = [],
        outputs = [ctx.outputs.outfile],
        executable = ctx.executable._tool,
        arguments = [ctx.outputs.out.path],
    )

flash_tool = rule(
    implementation = _stuff_rule_impl,
    attrs = {
        # cfg param is required, but doesn't matter whether it's "host" or "target"
        "_tool": attr.label(executable=True, default="//tools/flash:flash", cfg="exec"),
        "outfile": attr.output(),
    },
    executable = True
)
