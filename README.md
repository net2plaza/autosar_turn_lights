# AUTOSAR Development Project (Trampoline RTOS)

An educational implementation of an AUTOSAR-compliant "Turn Light" Software Component (SWC). This project documents the transition from virtualized ARMv7-A systems to bare-metal Cortex-M microcontrollers.

## Current Project Status
- **Target Hardware:** QEMU `virt` machine (ARMv7-VE / Cortex-A15).
- **OS:** Trampoline RTOS (OSEK/VDX & AUTOSAR compatible).
- **Modeling:** Python-based ARXML generation via `cogu/autosar`.
- **Toolchain:** `arm-none-eabi-gcc` on macOS.

## Key Artifacts
- `/swc`: Contains the Turn Light logic (`.c`) and OSEK configuration (`.oil`).
- `arm-wrapper.sh`: A custom pre-processing bridge for Trampoline assembly macros.
- Modified OS templates for the `virt-v7` platform support.

## Baseline Milestone
This version successfully compiles the low-level entry points and application logic for a virtual ARMv7 environment.
