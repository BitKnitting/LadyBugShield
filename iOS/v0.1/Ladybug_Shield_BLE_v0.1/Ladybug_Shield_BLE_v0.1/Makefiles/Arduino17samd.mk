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
# Last update: Apr 12, 2014 release 279






# Arduino 1.7.x SAMD specifics
# ----------------------------------
#
PLATFORM         := Arduino
BUILD_CORE       := samd
PLATFORM_TAG      = ARDUINO=10700 ARDUINO_SAM_ZERO ARDUINO_ARCH_SAMD EMBEDXCODE=$(RELEASE_NOW) ARDUINO_$(BOARD_NAME) $(filter __%__ ,$(GCC_PREPROCESSOR_DEFINITIONS))
APPLICATION_PATH := $(ARDUINO_ORG_PATH)

# New GCC for ARM tool-suite
#
APP_TOOLS_PATH   := $(APPLICATION_PATH)/hardware/tools/gcc-arm-none-eabi-4.8.3-2014q1/bin

CORE_LIB_PATH    := $(APPLICATION_PATH)/hardware/arduino/samd/cores/arduino
APP_LIB_PATH     := $(APPLICATION_PATH)/hardware/arduino/samd/libraries
BOARDS_TXT       := $(APPLICATION_PATH)/hardware/arduino/samd/boards.txt
BOARD_NAME       =  $(call PARSE_BOARD,$(BOARD_TAG),build.board)

FIRST_O_IN_A     = Builds/variant.cpp.o

VARIANT      = $(call PARSE_BOARD,$(BOARD_TAG),build.variant)
VARIANT_PATH = $(APPLICATION_PATH)/hardware/arduino/samd/variants/$(VARIANT)
VARIANT_CPP_SRCS  = $(wildcard $(VARIANT_PATH)/*.cpp) # */  $(VARIANT_PATH)/*/*.cpp #*/
VARIANT_OBJ_FILES = $(VARIANT_CPP_SRCS:.cpp=.cpp.o)
VARIANT_OBJS      = $(patsubst $(VARIANT_PATH)/%,$(OBJDIR)/%,$(VARIANT_OBJ_FILES))


# Uploader openocd or avrdude
# UPLOADER defined in .xcconfig
#
ifeq ($(UPLOADER),avrdude)
    UPLOADER         = avrdude
    USB_RESET        = python $(UTILITIES_PATH)/reset_1200.py
    AVRDUDE_COM_OPTS = -p$(AVRDUDE_MCU) -C$(AVRDUDE_CONF)
    AVRDUDE_OPTS     = -c$(AVRDUDE_PROGRAMMER) -b$(AVRDUDE_BAUDRATE)
else
    UPLOADER         = openocd
    UPLOADER_PATH    = $(APPLICATION_PATH)/hardware/tools/OpenOCD-0.9.0-dev-arduino
    UPLOADER_EXEC    = $(UPLOADER_PATH)/bin/openocd
    UPLOADER_OPTS    = -s $(UPLOADER_PATH)/share/openocd/scripts/
	UPLOADER_OPTS   += -f $(VARIANT_PATH)/$(call PARSE_BOARD,$(BOARD_TAG),build.openocdscript)
	UPLOADER_COMMAND = verify reset $(call PARSE_BOARD,$(BOARD_TAG),build.section.start)
endif

# Sketchbook/Libraries path
# wildcard required for ~ management
# ?ibraries required for libraries and Libraries
#
ifeq ($(USER_PATH)/Library/Arduino15/preferences.txt,)
    $(error Error: run Arduino once and define the sketchbook path)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
    SKETCHBOOK_DIR = $(shell grep sketchbook.path $(USER_PATH)/Library/Arduino15/preferences.txt | cut -d = -f 2)
endif

ifeq ($(wildcard $(SKETCHBOOK_DIR)),)
   $(error Error: sketchbook path not found)
endif

USER_LIB_PATH  = $(wildcard $(SKETCHBOOK_DIR)/?ibraries)

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
# ~
GDB     = $(APP_TOOLS_PATH)/arm-none-eabi-gdb
# ~~

# Specific AVRDUDE location and options
#

BOARD    = $(call PARSE_BOARD,$(BOARD_TAG),board)
LDSCRIPT = $(call PARSE_BOARD,$(BOARD_TAG),build.ldscript)

SYSTEM_LIB  = $(call PARSE_BOARD,$(BOARD_TAG),build.variant_system_lib)
SYSTEM_PATH = $(VARIANT_PATH)
SYSTEM_OBJS = $(SYSTEM_PATH)/$(SYSTEM_LIB)


# Two locations for Arduino libraries
#
BUILD_APP_LIB_PATH  = $(APPLICATION_PATH)/hardware/arduino/$(BUILD_CORE)/libraries

ifndef APP_LIBS_LIST
    a1501             = $(realpath $(sort $(dir $(wildcard $(APP_LIB_PATH)/*/*.h $(APP_LIB_PATH)/*/*/*.h $(APP_LIB_PATH)/*/*/*/*.h)))) # */
    APP_LIBS_LIST  = $(subst $(APP_LIB_PATH)/,,$(filter-out $(EXCLUDE_LIST),$(a1501)))

    a1502             = $(realpath $(sort $(dir $(wildcard $(BUILD_APP_LIB_PATH)/*/*.h $(BUILD_APP_LIB_PATH)/*/*/*.h $(BUILD_APP_LIB_PATH)/*/*/*/*.h)))) # */
    BUILD_APP_LIBS_LIST = $(subst $(BUILD_APP_LIB_PATH)/,,$(filter-out $(EXCLUDE_LIST),$(a1502)))
else
    a1502             = $(realpath $(sort $(dir $(wildcard $(BUILD_APP_LIB_PATH)/*/*.h $(BUILD_APP_LIB_PATH)/*/*/*.h $(BUILD_APP_LIB_PATH)/*/*/*/*.h)))) # */
    BUILD_APP_LIBS_LIST = $(subst $(BUILD_APP_LIB_PATH)/,,$(filter-out $(EXCLUDE_LIST),$(a1502)))
endif


# Arduino 1.5.x nightmare with src and arch/sam or arch/avr
# Another example of Arduino's quick and dirty job
#
ifneq ($(APP_LIBS_LIST),0)
    a1503              = $(patsubst %,$(APP_LIB_PATH)/%/src,$(APP_LIBS_LIST))
    a1503             += $(patsubst %,$(APP_LIB_PATH)/%/arch/$(BUILD_CORE),$(APP_LIBS_LIST))
    APP_LIBS        = $(realpath $(sort $(dir $(foreach dir,$(a1503),$(wildcard $(dir)/*.h $(dir)/*/*.h $(dir)/*/*/*.h))))) # */

    APP_LIB_CPP_SRC = $(realpath $(sort $(foreach dir,$(APP_LIBS),$(wildcard $(dir)/*.cpp $(dir)/*/*.cpp $(dir)/*/*/*.cpp))))
    APP_LIB_C_SRC   = $(realpath $(sort $(foreach dir,$(APP_LIBS),$(wildcard $(dir)/*.c $(dir)/*/*.c $(dir)/*/*/*.c))))

    APP_LIB_OBJS    = $(patsubst $(APP_LIB_PATH)/%.cpp,$(OBJDIR)/libs/%.cpp.o,$(APP_LIB_CPP_SRC))
    APP_LIB_OBJS   += $(patsubst $(APP_LIB_PATH)/%.c,$(OBJDIR)/libs/%.c.o,$(APP_LIB_C_SRC))

    BUILD_APP_LIBS        = $(patsubst %,$(BUILD_APP_LIB_PATH)/%,$(BUILD_APP_LIBS_LIST))

    BUILD_APP_LIB_CPP_SRC = $(wildcard $(patsubst %,%/*.cpp,$(BUILD_APP_LIBS))) # */
    BUILD_APP_LIB_C_SRC   = $(wildcard $(patsubst %,%/*.c,$(BUILD_APP_LIBS))) # */

    BUILD_APP_LIB_OBJS    = $(patsubst $(BUILD_APP_LIB_PATH)/%.cpp,$(OBJDIR)/libs/%.cpp.o,$(BUILD_APP_LIB_CPP_SRC))
    BUILD_APP_LIB_OBJS   += $(patsubst $(BUILD_APP_LIB_PATH)/%.c,$(OBJDIR)/libs/%.c.o,$(BUILD_APP_LIB_C_SRC))
endif

SYSTEM_FLAGS    = -I$(APPLICATION_PATH)/hardware/arduino/sam/system/libsam 
SYSTEM_FLAGS   += -I$(APPLICATION_PATH)/hardware/arduino/sam/system/libsam/include
SYSTEM_FLAGS   += -I$(APPLICATION_PATH)/hardware/arduino/sam/system/CMSIS/CMSIS/Include/
SYSTEM_FLAGS   += -I$(APPLICATION_PATH)/hardware/arduino/sam/system/CMSIS/Device/ATMEL/


# Arduino Zero Pro USB PID VID
#
USB_VID     := $(call PARSE_BOARD,$(BOARD_TAG),build.vid)
USB_PID     := $(call PARSE_BOARD,$(BOARD_TAG),build.pid)
USB_PRODUCT := $(call PARSE_BOARD,$(BOARD_TAG),build.usb_product)

USB_FLAGS    = -DUSB_VID=$(USB_VID)
USB_FLAGS   += -DUSB_PID=$(USB_PID)
USB_FLAGS   += -DUSBCON
USB_FLAGS   += '-DUSB_MANUFACTURER='
USB_FLAGS   += '-DUSB_PRODUCT=$(USB_PRODUCT)'


# Arduino Due serial 1200 reset
#
USB_TOUCH := $(call PARSE_BOARD,$(BOARD_TAG),upload.protocol)
USB_RESET  = python $(UTILITIES_PATH)/reset_1200.py


MCU_FLAG_NAME    = mcpu
MCU              = $(call PARSE_BOARD,$(BOARD_TAG),build.mcu)
F_CPU            = $(call PARSE_BOARD,$(BOARD_TAG),build.f_cpu)

# ~
ifeq ($(MAKECMDGOALS),debug)
    OPTIMISATION   = -O0 -g
else
    OPTIMISATION   = -Os
endif
# ~~

INCLUDE_PATH     = $(CORE_LIB_PATH) $(VARIANT_PATH)
INCLUDE_PATH    += $(APPLICATION_PATH)/hardware/tools/CMSIS/CMSIS/Include/
INCLUDE_PATH    += $(APPLICATION_PATH)/hardware/tools/CMSIS/Device/ATMEL/

# Flags for gcc, g++ and linker
# ----------------------------------
#
# Common CPPFLAGS for gcc, g++, assembler and linker
#
CPPFLAGS     = $(OPTIMISATION) $(WARNING_FLAGS)
CPPFLAGS    += -$(MCU_FLAG_NAME)=$(MCU) -DF_CPU=$(F_CPU)
CPPFLAGS    += -ffunction-sections -fdata-sections -nostdlib
CPPFLAGS    += --param max-inline-insns-single=500
CPPFLAGS    += $(addprefix -D, printf=iprintf $(PLATFORM_TAG))
CPPFLAGS    += -mthumb
# $(USB_FLAGS)
CPPFLAGS    += $(addprefix -I, $(INCLUDE_PATH))

# Specific CFLAGS for gcc only
# gcc uses CPPFLAGS and CFLAGS
#
CFLAGS       =

# Specific CXXFLAGS for g++ only
# g++ uses CPPFLAGS and CXXFLAGS
#
CXXFLAGS     = -fno-rtti -fno-exceptions

# Specific ASFLAGS for gcc assembler only
# gcc assembler uses CPPFLAGS and ASFLAGS
#
ASFLAGS      = -x assembler-with-cpp

# Specific LDFLAGS for linker only
# linker uses CPPFLAGS and LDFLAGS
#
LDFLAGS      = $(OPTIMISATION) -save-temps
LDFLAGS     += -$(MCU_FLAG_NAME)=$(MCU) --specs=nano.specs
LDFLAGS     += -T $(VARIANT_PATH)/$(LDSCRIPT) -mthumb
#LDFLAGS     += -Wl,--cref
LDFLAGS     += -Wl,--check-sections -Wl,--gc-sections -Wl,--entry=Reset_Handler
LDFLAGS     += -Wl,--unresolved-symbols=report-all
LDFLAGS     += -Wl,--warn-common -Wl,--warn-section-align -Wl,--warn-unresolved-symbols
LDFLAGS     += -Wl,--section-start=.text=$(call PARSE_BOARD,$(BOARD_TAG),build.section.start)


OBJCOPYFLAGS  = -v -Obinary
TARGET_HEXBIN = $(TARGET_BIN)


OBJCOPYFLAGS  = -O ihex -R .eeprom
TARGET_HEXBIN = $(TARGET_BIN)
#-O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0
TARGET_EEP    = $(OBJDIR)/$(TARGET).hex


