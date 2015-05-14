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
# Last update: Sep 30, 2014 release 204



# RFduino specifics
# ----------------------------------
#
#
PLATFORM         := RFduino
PLATFORM_TAG      = EMBEDXCODE=$(RELEASE_NOW) ARDUINO=157 RFDUINO
APPLICATION_PATH := $(RFDUINO_PATH)

UPLOADER          = RFDLoader
UPLOADER_PATH     = $(RFDUINO_PATH)/hardware/arduino/RFduino/
UPLOADER_EXEC     = $(UPLOADER_PATH)/RFDLoader

APP_TOOLS_PATH   := $(APPLICATION_PATH)/hardware/tools/gcc-arm-none-eabi-4.8.3-2014q1/bin
CORE_LIB_PATH    := $(APPLICATION_PATH)/hardware/arduino/RFduino/cores/arduino
APP_LIB_PATH     := $(APPLICATION_PATH)/hardware/arduino/RFduino/libraries
BOARDS_TXT       := $(APPLICATION_PATH)/hardware/arduino/RFduino/boards.txt

# Sketchbook/Libraries path
# wildcard required for ~ management
# ?ibraries required for libraries and Libraries
#
ifeq ($(USER_PATH)/Library/MapleIDE/preferences.txt,)
    $(error Error: run RFduino once and define the sketchbook path)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
    SKETCHBOOK_DIR = $(shell grep sketchbook.path $(USER_PATH)/Library/Arduino15/preferences.txt | cut -d = -f 2)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
    $(error Error: sketchbook path not found)
endif

USER_LIB_PATH  = $(wildcard $(SKETCHBOOK_DIR)/?ibraries)
CORE_AS_SRCS   = $(wildcard $(CORE_LIB_PATH)/*.S) # */


# Rules for making a c++ file from the main sketch (.pde)
#
PDEHEADER      = \\\#include \"Arduino.h\"  


# Tool-chain names
#
CC      = $(APP_TOOLS_PATH)/arm-none-eabi-gcc
CXX     = $(APP_TOOLS_PATH)/arm-none-eabi-g++
AR      = $(APP_TOOLS_PATH)/arm-none-eabi-ar
OBJDUMP = $(APP_TOOLS_PATH)/arm-none-eabi-objdump
OBJCOPY = $(APP_TOOLS_PATH)/arm-none-eabi-objcopy
SIZE    = $(APP_TOOLS_PATH)/arm-none-eabi-size
NM      = $(APP_TOOLS_PATH)/arm-none-eabi-nm

LDSCRIPT = $(call PARSE_BOARD,$(BOARD_TAG),build.ldscript)
VARIANT  = $(call PARSE_BOARD,$(BOARD_TAG),build.variant)
VARIANT_PATH = $(APPLICATION_PATH)/hardware/arduino/RFduino/variants/$(VARIANT)


MCU             = $(call PARSE_BOARD,$(BOARD_TAG),build.mcu)
MCU_FLAG_NAME   = mcpu

BUILD_CORE_LIB_PATH  = $(VARIANT_PATH)
BUILD_CORE_LIBS_LIST = $(subst .cpp,,$(subst $(BUILD_CORE_LIB_PATH)/,,$(wildcard $(BUILD_CORE_LIB_PATH)/*.cpp))) # */
BUILD_CORE_CPP_SRCS = $(filter-out %program.cpp %main.cpp,$(wildcard $(BUILD_CORE_LIB_PATH)/*.cpp)) # */
BUILD_CORE_OBJ_FILES  = $(BUILD_CORE_C_SRCS:.c=.c.o) $(BUILD_CORE_CPP_SRCS:.cpp=.cpp.o)
BUILD_CORE_OBJS       = $(patsubst $(BUILD_CORE_LIB_PATH)/%,$(OBJDIR)/%,$(BUILD_CORE_OBJ_FILES))


EXTRA_CPPFLAGS  = -fno-builtin $(call PARSE_BOARD,$(BOARD_TAG),build.extra_flags)
EXTRA_CPPFLAGS += $(addprefix -D, $(PLATFORM_TAG))
EXTRA_CPPFLAGS += $(addprefix -I$(RFDUINO_PATH)/hardware/arduino/RFduino/, variants/RFduino system/RFduino system/RFduino/include system/CMSIS/CMSIS/Include)

EXTRA_CXXFLAGS = -fno-rtti -fno-exceptions

LDFLAGS         = -Wl,--gc-sections --specs=nano.specs
LDFLAGS        += -Wl,--warn-common -Wl,--warn-section-align
LDFLAGS        += -Wl,-Map,$(OBJDIR)/embedXcode.cpp.map -Wl,--cref
LDFLAGS        += $(call PARSE_BOARD,$(BOARD_TAG),build.extra_flags) $(addprefix -D, $(PLATFORM_TAG))
LDFLAGS        += -$(MCU_FLAG_NAME)=$(MCU) -DF_CPU=$(F_CPU)
LDFLAGS        += -T$(VARIANT_PATH)/$(LDSCRIPT) -L$(OBJDIR)

INCLUDE_A       = $(wildcard $(VARIANT_PATH)/*.a) # */

OBJCOPYFLAGS  = -v -Oihex
TARGET_HEXBIN = $(TARGET_HEX)

MAX_RAM_SIZE = $(call PARSE_BOARD,$(BOARD_TAG),upload.ram.maximum_size)





