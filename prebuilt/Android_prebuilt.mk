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
LOCAL_MODULE        := libavcodec
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib/libavcodec.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavcodec
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib64/libavcodec.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavformat
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib/libavformat.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavformat
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib64/libavformat.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)


include $(CLEAR_VARS)
LOCAL_MODULE        := libavutil
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib/libavutil.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavutil
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib64/libavutil.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswresample
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib/libswresample.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswresample
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib64/libswresample.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswscale
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib/libswscale.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswscale
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib64/libswscale.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libdav1d
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so.4
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib/libdav1d.so.4
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libdav1d
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so.4
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_TAGS   := optional
LOCAL_SRC_FILES     := ./lib64/libdav1d.so.4
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

#*****************
#build vendor libs
#*****************

include $(CLEAR_VARS)
LOCAL_MODULE        := libavcodec_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libavcodec.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libavcodec
LOCAL_SRC_FILES     := ./lib/libavcodec.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavcodec_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libavcodec.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib64
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libavcodec
LOCAL_SRC_FILES     := ./lib64/libavcodec.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavformat_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libavformat.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libavformat
LOCAL_SRC_FILES     := ./lib/libavformat.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavformat_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libavformat.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib64
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libavformat
LOCAL_SRC_FILES     := ./lib64/libavformat.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavutil_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libavutil.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libavutil
LOCAL_SRC_FILES     := ./lib/libavutil.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libavutil_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libavutil.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib64
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libavutil
LOCAL_SRC_FILES     := ./lib64/libavutil.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswresample_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libswresample.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libswresample
LOCAL_SRC_FILES     := ./lib/libswresample.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswresample_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libswresample.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib64
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libswresample
LOCAL_SRC_FILES     := ./lib64/libswresample.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswscale_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libswscale.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libswscale
LOCAL_SRC_FILES     := ./lib/libswscale.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libswscale_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libswscale.so
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib64
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libswscale
LOCAL_SRC_FILES     := ./lib64/libswscale.so
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libdav1d_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libdav1d.so.4
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so.4
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 32
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libdav1d
LOCAL_SRC_FILES     := ./lib/libdav1d.so.4
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE        := libdav1d_vendor
LOCAL_PROPRIETARY_MODULE := true
LOCAL_INSTALLED_MODULE_STEM := libdav1d.so.4
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so.4
LOCAL_STRIP_MODULE  := false
LOCAL_MULTILIB      := 64
LOCAL_MODULE_PATH   := $(TARGET_OUT_VENDOR)/lib64
LOCAL_MODULE_TAGS   := optional
LOCAL_REQUIRED_MODULES := libdav1d
LOCAL_SRC_FILES     := ./lib64/libdav1d.so.4
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)
