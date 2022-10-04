def _impl(ctx):
    # in_files = ctx.files.srcs
    args= ctx.actions.args()
    args.add(ctx.attr.device_type)
    args.add(ctx.file.srcs.path)
    args.add(ctx.outputs.text.path)

    #  output_file = ctx.actions.declare_file(ctx.label.name)
    ctx.actions.run(
        inputs = [ctx.file.srcs, ctx.executable.runner],
        arguments = [args],
        outputs = [ctx.outputs.text],

        use_default_shell_env = True,
        executable = ctx.executable.runner)


flash_tool = rule(
    implementation = _impl,
    attrs = {
        "runner": attr.label(
            executable = True,
            cfg = "host",
            # allow_files = True,
            default=Label("//tools/flash")),
        "device_type":attr.string(mandatory = True),
        "srcs":attr.label(mandatory = True, allow_single_file = True,),
        # "file_path":attr.string(mandatory = True),
    },
    outputs = {
        "text": "%{name}.txt"},
    # executable = True,
)


# def _impl(ctx):

#     microncontroller_type = ctx.attr.device_type
#     hex_file_path = ctx.attr.file_path
    
#     script_template = """
# set -eo pipefail
# $RUNFILES_DIR/deploy {microncontroller_type} {hex_file_path}
# """

#     script = ctx.actions.declare_file("%s.sh" % ctx.label.name)

#     script_content = script_template.format(
#         microncontroller_type = microncontroller_type,
#         hex_file_path = hex_file_path,
#     )

#     ctx.actions.write(script, script_content, is_executable = True)
#     runfiles = ctx.runfiles(
#         files = [ctx.files._deploy[0]],
#         root_symlinks = {"deploy": ctx.files._deploy[0]},
#     )
#     return [DefaultInfo(executable = script, runfiles = runfiles)]

# flash_execution_wrapper = rule(
#     implementation = _impl,
#     attrs = {
#         "_deploy": attr.label(
#             cfg = "host",
#             # allow_single_file = True,
#             default=Label("//tools/flash:deploy")),
#         "device_type":attr.string(mandatory = True),
#         "file_path":attr.string(mandatory = True),
#     },
#     executable =True
# )
