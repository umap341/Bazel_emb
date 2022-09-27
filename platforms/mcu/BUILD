# Package overview.
# How are MCUs intended to be used and extended? Explain how they are shared
# between compilers and platforms.
package(default_visibility = ["//visibility:public"])

# MCU overview.
# MCUs are used to communicate with the deployment tools like JLink. It also is
# used to select simulation for desktop operating systems, or hardware drivers
# for specific microcontrollers.
constraint_value(
  name = "stm32f407VG",
  constraint_setting = "@platforms//os",
)

# Configurations.
config_setting(
    name = "stm32f407xx",
    constraint_values = [":stm32f407VG"],
)

constraint_value(
  name = "stm32l552ze",
  constraint_setting = "@platforms//os",
)

config_setting(
    name = "stm32l552xx",
    constraint_values = [":stm32l552ze"],
)

config_setting(
    name = "simulation",
    constraint_values = [
        "@platforms//os:windows",
        "@platforms//os:linux",
        "@platforms//os:macos",
    ],
)

# Support library overview
# Includes startup code and the peripherals dependencies, for any supported
# platform, including desktop.

# select() is the helper function that makes a rule attribute configurable. 
# It can replace the right-hand side of almost any attribute assignment so its value depends on command-line Bazel flags. 
cc_library(
    name = "microcontroller",
    deps = select({
        ":stm32f407VG" : [ "//third_party/stm32f4:startup","//third_party/stm32f4:linker"],
        ":stm32l552ze": ["//third_party/stm32l5:startup", "//third_party/stm32l5:linker"],
    }),
    visibility = ["//visibility:public"],
)
