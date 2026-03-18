#!/bin/bash
set -e

# lxcalder-oss: Hard-coded verified paths
TPL_BASE="$HOME/autosar/trampoline"
APP_BASE="$HOME/autosar-m0/autosar_turn_lights"

# Ensure dummy headers exist (AUTOSAR Requirement)
touch "$APP_BASE/swc/tpl_app_define.h"
touch "$APP_BASE/swc/AsMemMap.h"

while getopts "c:o:" opt; do
  case $opt in
    c) INPUT_FILE="$OPTARG" ;;
    o) OUTPUT_FILE="$OPTARG" ;;
  esac
done

# 2. Preprocess with the "Golden Includes"
arm-none-eabi-gcc -E -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft \
  -I. \
  -I"$APP_BASE/swc" \
  -I"$TPL_BASE/os" \
  -I"$TPL_BASE/machines/cortex-m" \
  -I"$TPL_BASE/machines/cortex-m/armv6m" \
  -D__ASSEMBLY__ \
  -DSYSCALL_COUNT=64 \
  "$INPUT_FILE" > temp_preprocessed.s

# 3. Assemble
arm-none-eabi-gcc -mcpu=cortex-m0plus -mthumb -c temp_preprocessed.s -o "$OUTPUT_FILE"

echo "SUCCESS: $OUTPUT_FILE generated for Cortex-M0+."
