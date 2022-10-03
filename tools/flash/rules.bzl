def _impl(ctx):

    microncontroller_type = ctx.attr.device_type
    hex_file_path = ctx.attr.file_path
    
    script_template = """
set -eo pipefail
$RUNFILES_DIR/deploy {microncontroller_type} {hex_file_path}
"""

    script = ctx.actions.declare_file("%s.sh" % ctx.label.name)

    script_content = script_template.format(
        microncontroller_type = microncontroller_type,
        hex_file_path = hex_file_path,
    )

    ctx.actions.write(script, script_content, is_executable = True)
    runfiles = ctx.runfiles(
        files = [ctx.files._deploy[0]],
        root_symlinks = {"deploy": ctx.files._deploy[0]},
    )
    return [DefaultInfo(executable = script, runfiles = runfiles)]

flash_execution_wrapper = rule(
    implementation = _impl,
    attrs = {
        "_deploy": attr.label(
            cfg = "host",
            # allow_single_file = True,
            default=Label("//tools/flash:deploy")),
        "device_type":attr.string(mandatory = True),
        "file_path":attr.string(mandatory = True),
    },
    executable =True
)
