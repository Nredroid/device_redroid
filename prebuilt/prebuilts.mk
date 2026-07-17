LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := amdgpu.ids.redroid
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := prebuilts/share/libdrm/amdgpu.ids
LOCAL_MODULE_RELATIVE_PATH := hwdata
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := libva-drm.so
LOCAL_INSTALLED_MODULE_STEM := libva-drm.so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES_$(TARGET_ARCH) := prebuilts/$(TARGET_ARCH)/lib/libva-drm.so
ifneq ($(TARGET_2ND_ARCH),)
LOCAL_SRC_FILES_$(TARGET_2ND_ARCH) := prebuilts/$(TARGET_2ND_ARCH)/lib/libva-drm.so
endif
LOCAL_MODULE_SUFFIX := .so
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := audio.primary.redroid
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES_$(TARGET_ARCH) := prebuilts/$(TARGET_ARCH)/lib/hw/audio.primary.redroid.so
ifneq ($(TARGET_2ND_ARCH),)
LOCAL_SRC_FILES_$(TARGET_2ND_ARCH) := prebuilts/$(TARGET_2ND_ARCH)/lib/hw/audio.primary.redroid.so
endif
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := uinputd
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_SRC_FILES_$(TARGET_ARCH) := prebuilts/$(TARGET_ARCH)/bin/uinputd
LOCAL_MULTILIB := first
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_INIT_RC := prebuilts/share/uinputd/uinputd.rc
include $(BUILD_PREBUILT)