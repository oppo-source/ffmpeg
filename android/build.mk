#
# Copyright (C) 2020 Oplus. All rights reserved.
#
# This file is part of FFmpeg.
#
# FFmpeg is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# FFmpeg is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with FFmpeg; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
#

ifndef FFDROID_DIR
FFDROID_DIR := $(call my-dir)
endif

define RESET
$(1) :=
$(1)-yes :=
endef

FF_VARS := FFLIBS OBJS ARMV5TE-OBJS ARMV6-OBJS VFP-OBJS NEON-OBJS MIPSFPU-OBJS MIPS32R2-OBJS MIPSDSPR1-OBJS MIPSDSPR2-OBJS ALTIVEC-OBJS VIS-OBJS MMX-OBJS YASM-OBJS

FFMPEG_ARCH := $(TARGET_ARCH)

FFMPEG_2ND_ARCH := false
ifneq ($(TARGET_2ND_ARCH_VARIANT),)
   ifeq ($(TARGET_PREFER_32_BIT_APPS),true)
       ifeq ($(FFMPEG_MULTILIB),64)
          FFMPEG_2ND_ARCH := true
       endif
   else
       ifeq ($(FFMPEG_MULTILIB),32)
          FFMPEG_2ND_ARCH := true
       endif
   endif
endif

ifeq ($(FFMPEG_2ND_ARCH), true)
    FFMPEG_ARCH := $(TARGET_2ND_ARCH)
endif

ifeq ($(FFMPEG_ARCH),arm64)
    FFMPEG_ARCH := aarch64
endif

$(foreach V,$(FF_VARS),$(eval $(call RESET,$(V))))
#$(warning INCLUDING $(wildcard $(LOCAL_PATH)/$(FFMPEG_ARCH)/Makefile) for $(FFMPEG_2ND_ARCH) - $(NEON-OBJS) - $(FF_VARS))

include $(CLEAR_VARS)
include $(FFDROID_DIR)/ffmpeg.mk
SUBDIR := $(FFDROID_DIR)/include/
include $(LOCAL_PATH)/Makefile $(wildcard $(LOCAL_PATH)/$(FFMPEG_ARCH)/Makefile)
include $(FFMPEG_DIR)arch.mak

# remove duplicate objects
OBJS := $(sort $(OBJS) $(OBJS-yes))

ASM_SUFFIX := $(if $(filter x86,$(FFMPEG_ARCH)),asm,S)
ALL_S_FILES := $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/$(FFMPEG_ARCH)/*.$(ASM_SUFFIX)))
ALL_S_FILES := $(if $(filter S,$(ASM_SUFFIX)),$(ALL_S_FILES),$(filter $(patsubst %.o,%.asm,$(YASM-OBJS) $(YASM-OBJS-yes)),$(ALL_S_FILES)))

ifneq ($(ALL_S_FILES),)
S_OBJS := $(ALL_S_FILES:%.$(ASM_SUFFIX)=%.o)
C_OBJS := $(filter-out $(S_OBJS),$(OBJS))
S_OBJS := $(filter $(S_OBJS),$(OBJS))
else
C_OBJS := $(OBJS)
S_OBJS :=
endif

C_FILES := $(C_OBJS:%.o=%.c)
S_FILES := $(S_OBJS:%.o=%.$(ASM_SUFFIX))

LOCAL_MODULE := lib$(NAME)
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_ARM_MODE := arm
ifdef TARGET_2ND_ARCH
LOCAL_MODULE_PATH_32 := $(TARGET_OUT)/lib
LOCAL_MODULE_PATH_64 := $(TARGET_OUT)/lib64
else
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
endif

LOCAL_SRC_FILES := $(C_FILES) $(if $(filter S,$(ASM_SUFFIX)),$(S_FILES))

intermediates := $(local-intermediates-dir)
ifeq ($(FFMPEG_ARCH),x86)
GEN := $(S_OBJS:%=$(intermediates)/%)
$(GEN): YASM := prebuilts/misc/$(BUILD_OS)-$(HOST_PREBUILT_ARCH)/yasm/yasm
$(GEN): YASMFLAGS := -felf -DPIC $(LOCAL_C_INCLUDES:%=-I%)
$(GEN): PRIVATE_CUSTOM_TOOL = $(YASM) $(YASMFLAGS) -Pconfig.asm -o $@ $<
$(GEN): $(intermediates)/%.o: $(LOCAL_PATH)/%.asm $(SUBDIR)config.asm
	$(transform-generated-source)
LOCAL_GENERATED_SOURCES += $(GEN)
endif

LOCAL_CFLAGS += \
	-O3 -std=c99 -fno-math-errno -fno-signed-zeros -fomit-frame-pointer \
	-Wno-pointer-to-int-cast -Wstrict-prototypes -Wempty-body -Wno-parentheses \
	-Wno-switch -Wno-format-zero-length -Wno-pointer-sign -Wno-unused-parameter \
	-Wno-unknown-attributes -Wno-missing-field-initializers -Wno-sign-compare \
	-Werror=format-security -Werror=implicit-function-declaration -Werror=missing-prototypes \
	-Werror=return-type -Werror=vla -Wformat -Wno-maybe-uninitialized -fPIC

LOCAL_LDFLAGS := -Wl,--no-fatal-warnings -Wl,-Bsymbolic

LOCAL_CLANG_ASFLAGS += -no-integrated-as

LOCAL_SHARED_LIBRARIES := $(sort $(FFLIBS-yes:%=lib%) $(FFLIBS:%=lib%))
