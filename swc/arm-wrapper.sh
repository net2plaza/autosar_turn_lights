#!/bin/bash
TPL_BASE="/Users/alejandrocalderonaveitua/autosar/trampoline"
APP_BASE="/Users/alejandrocalderonaveitua/autosar/swc/turn_light"

# 1. Separate the .S file
INPUT_FILE=""
GCC_ARGS=()
for arg in "$@"; do
    if [[ $arg == *.S ]]; then
        INPUT_FILE="$arg"
    else
        GCC_ARGS+=("$arg")
    fi
done

# 2. Preprocess
# -DSYSCALL_COUNT=64 is a safe default for virt-v7 if the header is missing
arm-none-eabi-gcc -E -march=armv7ve -marm \
-I. \
-I"$APP_BASE" \
-I"$TPL_BASE/os" \
-I"$TPL_BASE/autosar" \
-I"$TPL_BASE/machines/virt-v7" \
-I"$TPL_BASE/machines/virt-v7/armv7ve" \
-I"$TPL_BASE/machines/virt-v7/armv7ve/board" \
-D__ASSEMBLY__ \
-DSYSCALL_COUNT=64 \
"$INPUT_FILE" > temp_preprocessed.s

# 3. Assemble
arm-none-eabi-gcc "${GCC_ARGS[@]}" -march=armv7ve -marm -x assembler temp_preprocessed.s

# 4. Cleanup and Feedback
if [ $? -eq 0 ]; then
    rm temp_preprocessed.s
    echo "Successfully assembled: $INPUT_FILE"
else
    echo "--- ERROR DURING ASSEMBLY ---"
    # If it fails, let's see why the macros aren't expanding
    grep -n "set_current_mode" temp_preprocessed.s | head -n 5
fi
