#!/usr/bin/env python3
#
import subprocess
import sys

def validate():
    try:
        # Check if the compiler even exists
        result = subprocess.run(["arm-none-eabi-gcc", "--version"], capture_output=True, text=True)
        if "arm-none-eabi-gcc" in result.stdout:
            print("✓ Toolchain found.")
            return True
    except FileNotFoundError:
        print("✗ Error: arm-none-eabi-gcc not found in PATH.")
        return False

if __name__ == "__main__":
    if not validate():
        sys.exit(1)