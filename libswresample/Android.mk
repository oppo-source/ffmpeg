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

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
FFMPEG_MULTILIB := 32
include $(LOCAL_PATH)/../android/build.mk

LOCAL_MULTILIB := $(FFMPEG_MULTILIB)
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
FFMPEG_MULTILIB := 64
include $(LOCAL_PATH)/../android/build.mk

LOCAL_MULTILIB := $(FFMPEG_MULTILIB)
include $(BUILD_SHARED_LIBRARY)

#Add for ffmpeg omx
include $(CLEAR_VARS)
LOCAL_MODULE        :=  libswresample_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libswresample.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_REQUIRED_MODULES := libswresample
LOCAL_SRC_FILES     := ../../../../../$(TARGET_OUT)/lib/libswresample.so
include $(BUILD_PREBUILT)


include $(CLEAR_VARS)
LOCAL_MODULE        :=  libswresample_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libswresample.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_REQUIRED_MODULES := libswresample
LOCAL_SRC_FILES     := ../../../../../$(TARGET_OUT)/lib64/libswresample.so
include $(BUILD_PREBUILT)