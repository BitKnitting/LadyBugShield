#
# embedXcode
# ----------------------------------
# Embedded Computing on Xcode
#
# Copyright © Rei VILO, 2010-2015
# http://embedxcode.weebly.com
# All rights reserved
#
#
# Last update: Jan 06, 2015 release 250

INFO_MESSAGE = 'Building full Spark framework'

# Spark specifics
# ----------------------------------
#
# Download Spark SDK from https://github.com/spark/firmware/tree/feature/hal
#
CORE_LIB_PATH   = $(APPLICATION_PATH)/firmware/services


# More options
#
MORE_TARGET_EXCLUDE    = $(filter-out $(MORE_TARGET_INCLUDE),TARGET_M0 TARGET_M0P TARGET_M3 TARGET_M4)
MORE_TOOLCHAIN_EXCLUDE = $(filter-out $(MORE_TOOLCHAIN_INCLUDE),TOOLCHAIN_ARM TOOLCHAIN_GCC)

ifneq ($(EXCLUDE_NAMES),)
    EXCLUDE_LIST   += $(addprefix %,$(EXCLUDE_NAMES).h)
    EXCLUDE_LIST   += $(addprefix %,$(EXCLUDE_NAMES).c)
    EXCLUDE_LIST   += $(addprefix %,$(EXCLUDE_NAMES).cpp)
#    EXCLUDE_LIST   += $(addprefix %,$(EXCLUDE_NAMES).s)
endif

D_OPTIONS   = STM32_DEVICE SPARK_PRODUCT_ID=0 SPARK_PLATFORM PRODUCT_FIRMWARE_VERSION=65535
D_OPTIONS  += RELEASE_BUILD INCLUDE_PLATFORM=1 SPARK_PLATFORM_NET=$(LEVEL3)
D_OPTIONS  += USE_STDPERIPH_DRIVER DFU_BUILD_ENABLE


# CORE files
#
BUILD_CORE_LIB_PATH = $(APPLICATION_PATH)/firmware

u101                    = $(BUILD_CORE_LIB_PATH)
u101                   += $(BUILD_CORE_LIB_PATH)/communication/lib/tropicssl/include
u101                   += $(BUILD_CORE_LIB_PATH)/communication/lib/tropicssl/library
u101                   += $(BUILD_CORE_LIB_PATH)/communication/src
u101                   += $(BUILD_CORE_LIB_PATH)/hal/inc
u101                   += $(BUILD_CORE_LIB_PATH)/hal/shared
u101                   += $(BUILD_CORE_LIB_PATH)/hal/src/$(LEVEL1)
u101                   += $(BUILD_CORE_LIB_PATH)/main/inc
u101                   += $(BUILD_CORE_LIB_PATH)/main/libraries/Serial2
u101                   += $(BUILD_CORE_LIB_PATH)/main/libraries/Ymodem
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/CMSIS/Device/ST/Include
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/CMSIS/Include
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/SPARK_Firmware_Driver/inc
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/SPARK_Firmware_Driver/src
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/STM32_StdPeriph_Driver/inc
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/STM32_StdPeriph_Driver/src
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/STM32_USB_Device_Driver/inc
u101                   += $(BUILD_CORE_LIB_PATH)/platform/MCU/$(LEVEL2)/STM32_USB_Device_Driver/src
u101                   += $(BUILD_CORE_LIB_PATH)/platform/NET/$(LEVEL3)/$(LEVEL3)_Host_Driver
u101                   += $(BUILD_CORE_LIB_PATH)/build/arm/startup

u102                    = $(foreach dir,$(u101),$(wildcard $(dir)/*.c)) # */
BUILD_CORE_C_SRCS       = $(filter-out %/$(EXCLUDE_LIST),$(u102))
u103                    = $(foreach dir,$(u101),$(wildcard $(dir)/*.cpp)) # */
BUILD_CORE_CPP_SRCS     = $(filter-out %/$(EXCLUDE_LIST),$(u103))
#u104                    = $(foreach dir,$(u101),$(wildcard $(dir)/*.S)) # */
#BUILD_CORE_AS_SRCS      = $(filter-out %/$(EXCLUDE_LIST),$(u104))

BUILD_CORE_OBJ_FILES    = $(BUILD_CORE_C_SRCS:.c=.c.o) $(BUILD_CORE_CPP_SRCS:.cpp=.cpp.o)
BUILD_CORE_OBJS         = $(patsubst $(BUILD_CORE_LIB_PATH)/%,$(OBJDIR)/%,$(BUILD_CORE_OBJ_FILES))


# Special files
#
CORE_AS_SRCS            = $(CORE_LIB_PATH)/build/arm/startup/$(STARTUP)
STARTUP_O              := $(patsubst $(CORE_LIB_PATH)/%,$(OBJDIR)/%,$(CORE_AS_SRCS:.S=.S.o))


# APPlication files
#
APP_LIB_PATH          = $(BUILD_CORE_LIB_PATH)/wiring
u201                 += $(BUILD_CORE_LIB_PATH)/wiring/inc
u201                 += $(BUILD_CORE_LIB_PATH)/wiring/src

u202                  = $(foreach dir,$(u201),$(wildcard $(dir)/*.c)) # */
BUILD_APP_C_SRCS      = $(filter-out %/$(EXCLUDE_LIST),$(u202))
u203                  = $(foreach dir,$(u201),$(wildcard $(dir)/*.cpp)) # */
u204                  = $(filter-out %/$(EXCLUDE_LIST),$(u203))
BUILD_APP_CPP_SRCS    = $(filter-out %/main.cpp,$(u204))

BUILD_APP_LIBS_LIST   = $(subst $(BUILD_APP_LIB_PATH)/,,$(subst .c,,$(BUILD_APP_C_SRCS)) $(subst .cpp,,$(BUILD_APP_CPP_SRCS)))
BUILD_APP_LIBS        = $(BUILD_APP_LIB_PATH)

BUILD_APP_LIB_CPP_SRC = $(wildcard $(patsubst %,%/*.cpp,$(BUILD_APP_LIBS))) # */
BUILD_APP_LIB_C_SRC   = $(wildcard $(patsubst %,%/*.c,$(BUILD_APP_LIBS))) # */

BUILD_APP_LIB_OBJS    = $(patsubst $(BUILD_APP_LIB_PATH)/%.cpp,$(OBJDIR)/libs/%.cpp.o,$(BUILD_APP_CPP_SRCS))
BUILD_APP_LIB_OBJS   += $(patsubst $(BUILD_APP_LIB_PATH)/%.c,$(OBJDIR)/libs/%.c.o,$(BUILD_APP_C_SRCS))

APP_LIB_PATH          = $(APPLICATION_PATH)/firmware/libraries

ifeq ($(APP_LIBS_LIST),)
    $(error The option APP_LIBS_LIST = is not allowed for mbed. Please list the libraries.)
endif

ifneq ($(APP_LIBS_LIST),0)
    u301            = $(realpath $(sort $(foreach dir,$(APP_LIBS_LIST),$(shell find -L $(APP_LIB_PATH)/$(dir) -type d))))
    u302            = $(filter $(addprefix %/,$(MORE_TARGET_EXCLUDE)),$(u301))
    u303            = $(filter-out $(addsuffix /%,$(u302)),$(u301))
    u304            = $(filter-out $(addprefix %/,$(MORE_TOOLCHAIN_EXCLUDE)),$(u303))
    APP_LIBS_PATH   = $(filter-out $(addprefix %/,$(MORE_TARGET_EXCLUDE)),$(u304))

    APP_LIB_CPP_SRC = $(realpath $(sort $(foreach dir,$(APP_LIBS_PATH),$(wildcard $(dir)/*.cpp)))) # */
    APP_LIB_C_SRC   = $(realpath $(sort $(foreach dir,$(APP_LIBS_PATH),$(wildcard $(dir)/*.c)))) # */
    APP_LIB_AS_SRC  = $(realpath $(sort $(foreach dir,$(APP_LIBS_PATH),$(wildcard $(dir)/*.s)))) # */

    APP_LIB_OBJS    = $(patsubst $(APP_LIB_PATH)/%.cpp,$(OBJDIR)/libs/%.cpp.o,$(APP_LIB_CPP_SRC))
    APP_LIB_OBJS   += $(patsubst $(APP_LIB_PATH)/%.c,$(OBJDIR)/libs/%.c.o,$(APP_LIB_C_SRC))
    APP_LIB_OBJS   += $(patsubst $(APP_LIB_PATH)/%.s,$(OBJDIR)/libs/%.s.o,$(APP_LIB_AS_SRC))
endif


# USER files
# Sketchbook/Libraries path
# wildcard required for ~ management
# ?ibraries required for libraries and Libraries
#
ifeq ($(SPARK_PATH)/preferences.txt,)
    $(error Error: define sketchbook.path in preferences.txt first)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
    SKETCHBOOK_DIR = $(shell grep sketchbook.path $(SPARK_PATH)/preferences.txt | cut -d = -f 2-)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
    $(error Error: sketchbook path not found ($(SKETCHBOOK_DIR)))
endif

USER_LIB_PATH  = $(wildcard $(SKETCHBOOK_DIR)/?ibraries)


# VARIANT files
#
VARIANT_PATH = $(CORE_LIB_PATH)/targets/cmsis/$(LEVEL1)/$(LEVEL2)/$(TOOLCHAIN)


# SYSTEM files
#
SYSTEM_PATH = $(APPLICATION_PATH)/firmware/libraries/mbed/targets/hal/$(LEVEL1)/$(LEVEL2)
#SYSTEM_LIB  = $(call PARSE_BOARD,$(BOARD_TAG),build.variant_system_lib)
#SYSTEM_OBJS = $(SYSTEM_PATH)/$(SYSTEM_LIB)


# Include paths
#
INCLUDE_PATH  = $(BUILD_CORE_LIB_PATH)/api
INCLUDE_PATH += $(u101)
INCLUDE_PATH += $(u202)
INCLUDE_PATH += $(CORE_LIB_PATH)/inc
INCLUDE_PATH += $(BUILD_CORE_LIB_PATH)/communication/lib/tropicssl/include/tropicssl
INCLUDE_PATH += $(BUILD_CORE_LIB_PATH)/bootloader/src/core-v2
INCLUDE_PATH += $(BUILD_CORE_LIB_PATH)/wiring/inc
INCLUDE_PATH := $(filter-out %/src,$(INCLUDE_PATH))
INCLUDE_PATH += $(BUILD_CORE_LIB_PATH)/communication/src # an exception
INCLUDE_PATH += $(APP_LIBS)
INCLUDE_PATH += $(BUILD_CORE_LIB_PATH)/build/arm/startup
# Local libraries paths to be added in step2.mk


# Flags for gcc, g++ and linker
# ----------------------------------
#
# Common CPPFLAGS for gcc, g++, assembler and linker
#
#CPPFLAGS     = -MD -MP -MF  -Werror
CPPFLAGS     = -Wall -Wno-switch -fmessage-length=0 -fno-strict-aliasing
CPPFLAGS    += -g3 -gdwarf-2 -Os -$(MCU_FLAG_NAME)=$(MCU) -mthumb
CPPFLAGS    += $(OPTIMISATION) -ffunction-sections -fdata-sections -fno-builtin
CPPFLAGS    += $(FPU_OPTIONS)
CPPFLAGS    += $(addprefix -D, $(PLATFORM_TAG) $(BUILD_OPTIONS) $(MORE_OPTIONS) $(D_OPTIONS))
CPPFLAGS    += $(addprefix -I, $(INCLUDE_PATH))
# Local libraries paths to be added in step2.mk

# Specific CFLAGS for gcc only
# gcc uses CPPFLAGS and CFLAGS
#
CFLAGS       = -std=c99 -std=gnu99 -Wno-pointer-sign

# Specific CXXFLAGS for g++ only
# g++ uses CPPFLAGS and CXXFLAGS
#
CXXFLAGS      = -std=gnu++11 -fno-exceptions -fno-rtti

# Specific ASFLAGS for gcc assembler only
# gcc assembler uses CPPFLAGS and ASFLAGS
#
ASFLAGS      = -Wa,--defsym -Wa,SPARK_INIT_STARTUP=1 -x assembler-with-cpp

# Specific LDFLAGS for linker only
# linker uses CPPFLAGS and LDFLAGS
#
LDFLAGS       = -T$(BUILD_CORE_LIB_PATH)/build/arm/linker/$(LDSCRIPT)
LDFLAGS      += --specs=nano.specs -lc -lnosys -u _printf_float
LDFLAGS      += -nostartfiles -Xlinker --gc-sections

# Specific OBJCOPYFLAGS for objcopy only
# objcopy uses OBJCOPYFLAGS only
#
OBJCOPYFLAGS  = -Obinary
TARGET_HEXBIN = $(TARGET_BIN)


