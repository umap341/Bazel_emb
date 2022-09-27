import argparse

# The parameters that govern the operation of the application.
class Parameters(object):
  # The parameters are read using a static method.
  def __init__(self):
    pass

  # Reads the parameters from the command line.
  # \param[in] arguments - The string list of command line arguments.
  # \return The data-bound parameters if successful. Otherwise, the command
  #   line usage will be displayed on the console and the application will
  #   exit.
  @staticmethod
  def read(arguments):
    # Define the command line arguments.
    command_line_parser = argparse.ArgumentParser(
      description="Performs Coverity static analysis on a Bazel workspace.")
    command_line_parser.add_argument(
      "--device_type",
      help="The Bazel targets to analyze.")
    command_line_parser.add_argument(
      "--file_path",
      help="The Bazel targets to analyze.")

    # Return the parameters.
    # On failure, the command line usage will be displayed on the console and
    # the application will exit.
    command_line_parameters = command_line_parser.parse_args(arguments)
    return command_line_parameters
