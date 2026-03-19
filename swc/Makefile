#
# 18/06/2026
# net2plaza
# to do: provide Makefile with options
#	configure: it will enable to setup particularities of a development environment like $HOME
#	clean: it will clean any artifacts generated for this specific development
#   build: vitr-v7 or m0+ 
# 
# Usage:
# Clean generated artifacts
# make clean
# 
# --- Global Paths ---
TPL_BASE ?= $(HOME)/autosar/trampoline
# Note: Keeping your original APP_BASE from the v7 wrapper
APP_BASE ?= $(HOME)/autosar/swc/turn_light
M0_APP_BASE ?= $(HOME)/autosar-m0/autosar_turn_lights

ARCH ?= v7

# --- Architecture Logic: Source & Flags ---
ifeq ($(ARCH),v7)
    CPU_FLAGS = -march=armv7ve -marm
    MACH_DIR  = $(TPL_BASE)/machines/virt-v7/armv7ve
    # Virt-v7 uses arm_entry_v7.S as the primary assembly target
    SRC_FILE  = $(MACH_DIR)/arm_entry_v7.S
    SPEC_INC  = -I$(TPL_BASE)/machines/virt-v7 -I$(MACH_DIR) -I$(MACH_DIR)/board
    CURRENT_APP = $(APP_BASE)
else ifeq ($(ARCH),m0plus)
    CPU_FLAGS = -mcpu=cortex-m0plus -mthumb
    MACH_DIR  = $(TPL_BASE)/machines/cortex-m/armv6m
    # M0+ uses tpl_ctx_switch.S for the context switch port
    SRC_FILE  = $(MACH_DIR)/tpl_ctx_switch.S
    SPEC_INC  = -I$(TPL_BASE)/machines/cortex-m -I$(MACH_DIR)
    CURRENT_APP = $(M0_APP_BASE)/swc
endif

# --- Validation ---
ifeq ($(wildcard $(SRC_FILE)),)
    $(error Source file not found: $(SRC_FILE). Check TPL_BASE or ARCH settings)
endif

# --- Compiler Settings ---
CC      = arm-none-eabi-gcc
INCLUDES = -I. -I$(CURRENT_APP) -I$(TPL_BASE)/os -I$(TPL_BASE)/autosar $(SPEC_INC)
ALL_CPPFLAGS = $(INCLUDES) -DSYSCALL_COUNT=64 -D__ASSEMBLY__

# --- Build Rules ---
# Target name matches the input file name but with .o
OBJ_FILE = $(notdir $(SRC_FILE:.S=.o))

$(OBJ_FILE): $(SRC_FILE)
	@echo "--- Assembling [$(ARCH)] ---"
	@echo "Source: $<"
	$(CC) -E $(ALL_CPPFLAGS) $< > temp.s
	$(CC) $(CPU_FLAGS) -c temp.s -o $@
	@rm temp.s

# --- Phony Targets ---
.PHONY: v7_ctx m0_ctx clean prepare

v7_ctx: arm_entry_v7.o
	@echo "SUCCESS: Virt-v7 entry assembled."

m0_ctx: tpl_ctx_switch.o
	@echo "SUCCESS: M0+ context switch assembled."

prepare:
	@mkdir -p $(CURRENT_APP)
	@touch $(CURRENT_APP)/tpl_app_define.h
	@touch $(CURRENT_APP)/AsMemMap.h

clean:
	rm -f *.o temp.s