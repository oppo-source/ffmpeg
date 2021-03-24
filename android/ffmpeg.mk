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

ifndef FFMPEG_DIR
FFMPEG_DIR := $(dir $(call my-dir))
endif

FFMPEG_ARCH_VARIANT := $(TARGET_ARCH_VARIANT)
ifeq ($(FFMPEG_2ND_ARCH), true)
#ifndef VENDOR_EDIT
#Wuhan@PSW.MM.MediaServer.Player., 2018/09/17,
#Modify for compile error
#  FFMPEG_ARCH_VARIANT := $(TARGET_2ND_ARCH_VARIANT)
#else /* VENDOR_EDIT */
   FFMPEG_ARCH_VARIANT := armv7-a-neon
#endif /* VENDOR_EDIT */
endif

# bionic include must be the first
LOCAL_C_INCLUDES := \
	$(FFMPEG_DIR)android/include \
	$(FFMPEG_DIR) \

LOCAL_CFLAGS := \
	-DANDROID_SDK_VERSION=$(PLATFORM_SDK_VERSION) \
	-DTARGET_CONFIG=\"config-$(FFMPEG_ARCH_VARIANT).h\" \
	-DHAVE_AV_CONFIG_H -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DPIC \

LOCAL_ASFLAGS := $(LOCAL_CFLAGS)
