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
# Last update: Sep 20, 2014 release 177

# MAPLE SUPPORT IS PUT ON HOLD
WARNING_MESSAGE = 'MAPLE SUPPORT IS PUT ON HOLD'


# Robotis specifics
# ----------------------------------
#
# The Maple reset script —which sends control signals over
# the USB-serial connection to restart and enter the bootloader—
# is written in Python and requires the PySerial library. 
#
# Instructions available at http://leaflabs.com/docs/unix-toolchain.html#os-x
# Download PySerial library from http://pypi.python.org/pypi/pyserial
#
#
PLATFORM         := Robotis
PLATFORM_TAG      = ROBOTIS EMBEDXCODE=$(RELEASE_NOW)
APPLICATION_PATH := $(ROBOTIS_PATH)

UPLOADER          = robotis-loader
UPLOADER_PATH     = $(UTILITIES_PATH)
UPLOADER_EXEC     = $(UPLOADER_PATH)/uploader_robotis
#UPLOADER_OPTS     = -a$(call PARSE_BOARD,$(BOARD_TAG),upload.altID) -d $(call PARSE_BOARD,$(BOARD_TAG),upload.usbID)
#UPLOADER_RESET    = $(UTILITIES_PATH)/reset.py

APP_TOOLS_PATH   := $(APPLICATION_PATH)/hardware/tools/arm/bin
CORE_LIB_PATH    := $(APPLICATION_PATH)/hardware/robotis/cores/robotis
APP_LIB_PATH     := $(APPLICATION_PATH)/libraries
BOARDS_TXT       := $(APPLICATION_PATH)/hardware/robotis/boards.txt

# Sketchbook/Libraries path
# wildcard required for ~ management
# ?ibraries required for libraries and Libraries
#
ifeq ($(USER_PATH)/Library/MapleIDE/preferences.txt,)
    $(error Error: run Robotis OpenCM once and define the sketchbook path)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
    SKETCHBOOK_DIR = $(shell grep sketchbook.path $(USER_PATH)/Library/ROBOTIS/preferences.txt | cut -d = -f 2)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
    $(error Error: sketchbook path not found)
endif

USER_LIB_PATH  = $(wildcard $(SKETCHBOOK_DIR)/?ibraries)
CORE_AS_SRCS   = $(wildcard $(CORE_LIB_PATH)/*.S) # */


# Rules for making a c++ file from the main sketch (.pde)
#
PDEHEADER      = \\\#include \"WProgram.h\"  


# Tool-chain names
#
CC      = $(APP_TOOLS_PATH)/arm-none-eabi-gcc
CXX     = $(APP_TOOLS_PATH)/arm-none-eabi-g++
AR      = $(APP_TOOLS_PATH)/arm-none-eabi-ar
OBJDUMP = $(APP_TOOLS_PATH)/arm-none-eabi-objdump
OBJCOPY = $(APP_TOOLS_PATH)/arm-none-eabi-objcopy
SIZE    = $(APP_TOOLS_PATH)/arm-none-eabi-size
NM      = $(APP_TOOLS_PATH)/arm-none-eabi-nm

BOARD    = $(call PARSE_BOARD,$(BOARD_TAG),build.board)
LDSCRIPT = $(call PARSE_BOARD,$(BOARD_TAG),build.linker)
VARIANT  = $(call PARSE_BOARD,$(BOARD_TAG),build.mcu)
#VARIANT_PATH = $(APPLICATION_PATH)/hardware/leaflabs/cores/maples/$(VARIANT)


MCU             = $(call PARSE_BOARD,$(BOARD_TAG),build.family)
MCU_FLAG_NAME   = mcpu

EXTRA_LDFLAGS   = -T$(CORE_LIB_PATH)/$(LDSCRIPT) -L$(APPLICATION_PATH)/hardware/robotis/cores/robotis
EXTRA_LDFLAGS  += -mthumb -Xlinker --gc-sections -Wall

EXTRA_CPPFLAGS  = -nostdlib -Wl,--gc-sections -mthumb -march=armv7-m
EXTRA_CPPFLAGS += -DBOARD_$(BOARD) -DMCU_$(call PARSE_BOARD,$(BOARD_TAG),build.mcu)
EXTRA_CPPFLAGS += -D$(call PARSE_BOARD,$(BOARD_TAG),build.vect)
EXTRA_CPPFLAGS += -D$(call PARSE_BOARD,$(BOARD_TAG),build.density)
#EXTRA_CPPFLAGS += -DERROR_LED_PORT=$(call PARSE_BOARD,$(BOARD_TAG),build.error_led_port)
#EXTRA_CPPFLAGS += -DERROR_LED_PIN=$(call PARSE_BOARD,$(BOARD_TAG),build.error_led_pin)
EXTRA_CPPFLAGS += $(addprefix -D, $(PLATFORM_TAG))
    
EXTRA_CXXFLAGS = -fno-rtti -fno-exceptions -Wall

OBJCOPYFLAGS  = -v -Obinary 
TARGET_HEXBIN = $(TARGET_BIN)

MAX_RAM_SIZE = $(call PARSE_BOARD,$(BOARD_TAG),upload.ram.maximum_size)





