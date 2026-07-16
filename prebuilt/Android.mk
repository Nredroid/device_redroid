LOCAL_PATH := $(call my-dir)

# $(1): module name; required
# $(2): module stem name if non-empty
# $(3): source file name 
# $(4): relative install dir
# $(5): create symbolic links
# $(6): depend modules
define define-redroid-prebuilt-lib
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
ifneq ($2,)
LOCAL_INSTALLED_MODULE_STEM := $2
endif

ifneq ($3,)
src := $3
else
src := $1
endif
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES_$$(TARGET_ARCH) := prebuilts/$$(TARGET_ARCH)/lib/$$(src)
ifneq ($$(TARGET_2ND_ARCH),)
LOCAL_SRC_FILES_$$(TARGET_2ND_ARCH) := prebuilts/$$(TARGET_2ND_ARCH)/lib/$$(src)
endif
#LOCAL_STRIP_MODULE := false
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_RELATIVE_PATH := $4
LOCAL_MULTILIB := both
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_SYMLINKS := $5
LOCAL_CHECK_ELF_FILES := false
LOCAL_REQUIRED_MODULES := $6
include $$(BUILD_PREBUILT)
endef


# $(1): module name; required
# $(2): module stem name if non-empty
# $(3): source file name 
# $(4): relative install dir
# $(5): create symbolic links
# $(6): depend modules
define define-redroid-prebuilt-etc
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
ifneq ($2,)
LOCAL_INSTALLED_MODULE_STEM := $2
endif

ifneq ($3,)
src := $3
else
src := $1
endif
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := prebuilts/$$(TARGET_ARCH)/share/$$(src)
LOCAL_MODULE_RELATIVE_PATH := $4
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_SYMLINKS := $5
LOCAL_REQUIRED_MODULES := $6
include $$(BUILD_PREBUILT)
endef

# DRI
ifneq (,$(filter $(TARGET_ARCH),x86 x86_64))
ifeq (,$(filter $(PLATFORM_VERSION), 15 16 17))
$(eval $(call define-redroid-prebuilt-lib,libigdgmm,,libigdgmm.so))
endif
endif

## amdgpu.ids
$(eval $(call define-redroid-prebuilt-etc,amdgpu.ids.redroid,,libdrm/amdgpu.ids,hwdata))

## VA
ifeq (,$(filter $(PLATFORM_VERSION), 15 16 17))
va_libs := libva-drm.so
$(foreach lib,$(va_libs),\
    $(eval $(call define-redroid-prebuilt-lib,$(lib),$(lib),,,,$(drm_libs))))
endif


# redroid audio
$(eval $(call define-redroid-prebuilt-lib,audio.primary.redroid,,hw/audio.primary.redroid.so,hw))

# redroid hwcomposer
$(eval $(call define-redroid-prebuilt-lib,hwcomposer.redroid,,hw/hwcomposer.redroid.so,hw))

# $(1): module name (and file name)
# $(2): depended modules
# $(3): init.rc
define define-redroid-prebuilt-bin
include $$(CLEAR_VARS)
LOCAL_MODULE := $1
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_SRC_FILES_$$(TARGET_ARCH) := prebuilts/$$(TARGET_ARCH)/bin/$1
#LOCAL_STRIP_MODULE := false
LOCAL_MULTILIB := first
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true
LOCAL_CHECK_ELF_FILES := false
LOCAL_REQUIRED_MODULES := $2
ifneq ($3,)
LOCAL_INIT_RC := prebuilts/$$(TARGET_ARCH)/share/$3
endif
include $$(BUILD_PREBUILT)
endef

$(eval $(call define-redroid-prebuilt-bin,uinputd,$(evdev_libs),uinputd/uinputd.rc))