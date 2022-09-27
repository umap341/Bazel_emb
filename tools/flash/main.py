#!/usr/bin/python
import os
import re
import shutil
import subprocess
import sys
from typing import List

from tools.flash.parameters import Parameters

# Performs Coverity static analysis on a given workspace.
def main(arguments):
  # Read the command line parameters.
  parameters = Parameters.read(arguments)

  flash = flash_code(parameters.device_type, parameters.file_path)
#   flash = flash_code("stm32f407xx","C:/Users/patilu3/Bazel_Projects/bazel-build-sample/bazel-out/x64_windows-fastbuild/bin/examples/application/app.hex")
  if not flash:
    print("The flash build failed (flash-build).")
    return 1
  else:
    print("Flashing Successfull!!!")


# Captures the build for the given Bazel targets with Coverity.
# \param[in] target_pattern - The Bazel targets to build and capture.
# \param[in] output_path - The path to the Coverity intermediate directory.
# \returns True if the build was successful, false otherwise.
def flash_code(device_type: str , hex_file_path: str):
    """
    Flashes microcontroller.
    The method flashes mcu using ST-Link Utility's CLI interface.
    To keep things simple most of the flags are hardcoded.
    Args:
        hex_file_path: Path of the hex file that will be used to flash the mcu
        probe: the probe number of the ST-Link programmer. Default is zero.
    Returns:
        flash_status: Either 'successful' or 'failed'
        checksum: the hex file checksum provided by ST-Link Utility CLI.
            It will be zero if programming fails.
    """

    st_link_list= findall()
    print('List of ST-Link:',st_link_list)
    print('Flashing:...', end='')

    device_sn = ""
    for i in st_link_list:
        for key,val in i.items():
            for j in i["Family"] :
                if j[0:9].lower() == device_type[0:9].lower():
                    device_sn = i["sn"]
                    break

    try:
        programming_output = subprocess.check_output(
            [
                'ST-LINK_CLI.exe',
                '-c',
                'SN=' + str(device_sn),
                'SWD',
                'UR',
                'Hrst',
                '-Q',
                '-P',
                hex_file_path,
                '-V',
                '-HardRST',
                'HIGH',
                '-Rst',
            ],
            stderr=subprocess.STDOUT,
            stdin=subprocess.PIPE).decode().splitlines()
    except subprocess.CalledProcessError as err:
        programming_output = err.output.decode().splitlines()

    return _check_flash_output(programming_output)

def findall():
    """
    Finds details of STLinks connected.
    The method maps ST-LINK sn to device ID.
    Returns:
        stlink_list: A list of dictionaries consists of sn number and device ID.
            If no ST-Link programmers can be found then the method will return None.
        Example - stlink_list = [{'sn': '0586868686866', 'ID': '0x423'}, {'sn': '521122222', 'ID': '0x413'}]
    """
    probes = _find_probe_and_sn()

    def my_split(s, delim, var):
        output = []
        output= device_family.split("/")
        device=[]
        substring = ''
        for c in output:
            if c[0:5] == "STM32":
                device.append(c)
            else:
                device.append(var+c)
        return device

    stlink_list = list()
    for probe in probes:
        try:
            stlink_device = subprocess.run(
                ["ST-LINK_CLI.exe", "-c", "SWD", "SN="+probe['sn'], "UR"],
                check=False,
                stdout=subprocess.PIPE).stdout.decode().splitlines()
            for i, line in enumerate(stlink_device):
                device = dict()
                device['sn'] = probe['sn']  
                if re.search('^Device family:', line):
                    device_family = re.findall('family: ([A-Z0-9A-Z0-9a-z/]+)', stlink_device[i])[0]                        
                    # device['Family']= device_family.split("/")
                    device['Family']= my_split(device_family,"/","STM32")
                    stlink_list.append(device)
        except FileNotFoundError:
            print('ST-LINK_CLI.exe is missing! Put in the same directory or add path into PATH.')
            return None  
    return stlink_list

def _find_probe_and_sn():
    """
    Finds ST-Link programmer's probe and hardware serial number.
    The method uses ST-Link Utility's CLI interface to find ST-Link V2 programmers if there are any.
    Returns:
        probe_list: A list of dictionaries consists of probe number and hardware serial
            number. If no ST-Link programmers can be found then the method will return None.
        Example -> probe_list = [{'probe': '0', 'sn': '21324515'}, {'probe': '1', 'sn': '21ABC54'}]
    Raises:
        FileNotFoundError: ST-Link Utility CLI isn't present in the current directory or on PATH.
    """

    try:
        stlink_output = subprocess.run(
            ["ST-LINK_CLI.exe", "-List"],
            check=False,
            stdout=subprocess.PIPE).stdout.decode().splitlines()
    except FileNotFoundError:
        print('ST-LINK_CLI.exe is missing! Put in the same directory or add path into PATH.')
        return None

    if 'No ST-LINK detected!' in stlink_output:
        print('No ST-LINK detected!')
        return None

    probe_list = list()
    for i, line in enumerate(stlink_output):
        if re.search('^ST-LINK Probe', line):
            device = dict()
            device['sn'] = re.findall('SN: ([A-Z0-9]+)', stlink_output[i + 1])[0]
            probe_list.append(device)

    return probe_list

def _check_flash_output(output: List[str]):
    checksum = 0
    flash_status = 'failed'

    for i, line in enumerate(output):
        if line.startswith('Memory programmed'):
            if output[i + 1] == 'Verification...OK' and output[i + 2] == 'Programming Complete.':
                checksum = output[i + 3].split()[3]  # type: ignore
                flash_status = 'True'
                break

    return flash_status

# if __name__ == '__main__':
#     status, checksum = flash('C:/Users/patilu3/Bazel_Projects/bazel-build-sample/bazel-out/x64_windows-fastbuild/bin/examples/application/app.hex', 'stm32f407xx')
#     print(status)

# Check if the script was run from the command line.
if __name__ == "__main__":
  return_code = main(sys.argv[1:])
  sys.exit(return_code)
