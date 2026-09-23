TARGET = main

BUILD_DIR = Build
LD_SCRIPT = STM32L432KC.ld
MCU_SPEC = cortex-m4

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OC = arm-none-eabi-objcopy
OD = arm-none-eabi-objdump
OS = arm-none-eabi-size

ASFLAGS = -c
ASFLAGS += -O0
ASFLAGS += -mcpu=$(MCU_SPEC)
ASFLAGS += -mthumb
ASFLAGS += -Wall
ASFLAGS += -fmessage-length=0

C_DEFS = -DSTM32L432xx
CMSIS_CORE_PATH = C:/Toolchains/CMSIS_6/CMSIS/Core/Include
CMSIS_DEVICE_PATH = C:/Toolchains/cmsis-device-l4/Include

C_INCLUDES = -I$(CMSIS_CORE_PATH) \
             -I$(CMSIS_DEVICE_PATH) \
             -IInc

CFLAGS = -mcpu=$(MCU_SPEC)
CFLAGS += -mthumb
CFLAGS += -Wall
CFLAGS += -g3
CFLAGS += -fmessage-length=0
CFLAGS += --specs=nosys.specs
CFLAGS += -O0
CFLAGS += $(C_DEFS) $(C_INCLUDES)


LSCRIPT = ./$(LD_SCRIPT)
LFLAGS += -mcpu=$(MCU_SPEC)
LFLAGS += -mthumb
LFLAGS += -Wall
LFLAGS += --specs=nosys.specs
LFLAGS += -nostdlib
LFLAGS += -lgcc
LFLAGS += -T$(LSCRIPT)

AS_SRC = Src/core.S
C_SRC = Src/main.c Src/helpers.c Src/nvic.c

OBJS = $(addprefix $(BUILD_DIR)/, $(notdir $(AS_SRC:.S=.o)))
OBJS += $(addprefix $(BUILD_DIR)/, $(notdir $(C_SRC:.c=.o)))

.PHONY: all clean
all: $(BUILD_DIR)/$(TARGET).bin

$(BUILD_DIR)/%.o: Src/%.S | $(BUILD_DIR)
	$(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@

$(BUILD_DIR)/%.o: Src/%.c | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJS)
	$(CC) $^ $(LFLAGS) -o $@

$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	$(OC) -S -O binary $< $@
	$(OS) $<

$(BUILD_DIR):
	if not exist "$(BUILD_DIR)" mkdir "$(BUILD_DIR)"

clean:
	-rmdir /S /Q $(BUILD_DIR) 2>NUL