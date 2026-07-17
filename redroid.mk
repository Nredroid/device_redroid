# Copyright (C) 2013 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_MANUFACTURER := redroid

#$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
#PRODUCT_COMPRESSED_APEX := false
OVERRIDE_PRODUCT_COMPRESSED_APEX := false

$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# no kernel involved
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

PRODUCT_BUILD_CACHE_IMAGE := false
PRODUCT_BUILD_ODM_IMAGE := false
PRODUCT_BUILD_SYSTEM_DLKM_IMAGE := false
PRODUCT_BUILD_PRODUCT_IMAGE  := false
PRODUCT_BUILD_PRODUCT_SERVICES_IMAGE := false
PRODUCT_BUILD_RAMDISK_IMAGE := false
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_BUILD_SYSTEM_OTHER_IMAGE := false
PRODUCT_BUILD_USERDATA_IMAGE := false
PRODUCT_BUILD_VBMETA_IMAGE := false
PRODUCT_BUILD_VENDOR_IMAGE := true

ifeq ($(BUILD_VENDOR_ONLY), true)
PRODUCT_BUILD_SYSTEM_IMAGE := false
else
PRODUCT_BUILD_SYSTEM_IMAGE := true
endif

PRODUCT_SHIPPING_API_LEVEL := 36

AUDIOSERVER_MULTILIB := first

TARGET_VENDOR_PROP += device/redroid/redroid.prop

PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle \
    vulkan.pastel \
    libva \
    libva-android \
    libdrm \
# Mesa3d

PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service.minigbm_dmabuf \
    android.hardware.graphics.mapper@4.0-impl.minigbm_dmabuf \
    gralloc.minigbm_dmabuf


PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service.minigbm \
    android.hardware.graphics.allocator@4.0-service.minigbm_gbm_mesa \
    android.hardware.graphics.mapper@4.0-impl.minigbm \
    android.hardware.graphics.mapper@4.0-impl.minigbm_gbm_mesa \
    gralloc.minigbm \
    gralloc.minigbm_gbm_mesa

PRODUCT_PACKAGES += \
    dri_gbm \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libgallium_drv_video \
    libgbm_mesa_wrapper \
    vulkan.lvp \
    vulkan.virtio


ifneq ($(filter %_x86 %_x86_64,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += i965_drv_video iHD_drv_video
PRODUCT_PACKAGES += \
    vulkan.intel \
    vulkan.intel_hasvk \
    vulkan.radeon \
    vulkan.nouveau
else
PRODUCT_PACKAGES += \
    vulkan.freedreno \
    vulkan.broadcom \
    vulkan.panfrost
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml


# Phone App required
PRODUCT_PACKAGES += \
    rild

# WiFi required by SystemUI
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \

PRODUCT_COPY_FILES += device/redroid/c2/redroid.c2.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/redroid.c2.rc
# required HIDL
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    android.hardware.audio.service \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.drm@1.4-service-lazy.clearkey \
    android.hardware.gatekeeper@1.0-service.software \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.bluetooth.audio-impl \
    android.hardware.health-service.example \
    android.hardware.keymaster@4.1-service \
    android.hardware.power-service.example \
    android.hardware.thermal@2.0-service.mock \
    hwservicemanager \

DEVICE_MANIFEST_FILE += device/redroid/android.hardware.bluetooth@1.1.xml

PRODUCT_PACKAGES += android.hardware.bluetooth@1.1-service.sim
#Bootloader
TARGET_NO_BOOTLOADER := true

PRODUCT_SOONG_NAMESPACES += frameworks/av/services/audiopolicy/config
# audio policy
PRODUCT_PACKAGES += \
    audio_policy_configuration.xml \
    r_submix_audio_policy_configuration.xml \
    audio_policy_volumes.xml \
    default_volume_tables.xml \
    primary_audio_policy_configuration.xml \
    surround_sound_configuration_5_0.xml \
#Support Battery
PRODUCT_PACKAGES += android.hardware.health-service.example
#Fix keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service android.hidl.allocator@1.0-service

PRODUCT_COPY_FILES += \
    device/redroid/mediaswcodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaswcodec.policy \
    external/mesa3d/src/util/00-mesa-defaults.conf:$(TARGET_COPY_OUT_VENDOR)/etc/drirc \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    device/redroid/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \

#Import generic_ramdisk to get first_stage_init for android 17
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
# Camera
USE_CAMERA_V4L2_HAL := true

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.7-external-service \
    camera.v4l2

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/camera/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml

# required by Settings
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
# build Mesa3d
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_MESON_ARGS := -Dallow-kcmp=enabled -Dmesa-clc=system -Dprecomp-compiler=system
BOARD_MESA3D_BUILD_LIBGBM := true
BOARD_MESA3D_GALLIUM_DRIVERS := llvmpipe svga virgl radeonsi zink
BOARD_MESA3D_VULKAN_DRIVERS := swrast virtio amd

$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

$(call inherit-product-if-exists, product.mk)

$(call inherit-product, vendor/redroid/vendor.mk)


PRODUCT_PACKAGES += \
    amdgpu.ids.redroid \
    vulkan.broadcom \
    vulkan.freedreno \
    vulkan.radeon \
    vulkan.nouveau \
    gralloc.cros \
    gralloc.gbm \
    uinputd \
    hwcomposer.redroid \
    libdrm_amdgpu \
    libdrm_radeon \
    libdrm_nouveau \
    libdrm_freedreno \
    libdrm_etnaviv \
    libdrm_intel \
    libglapi \
    libevdev \
    libigdgmm_android \
    audio.primary.redroid \
    libva-drm.so

# vaapi
PRODUCT_PACKAGES += avcenc h264encode hevcencode jpegenc vp8enc vp9enc vainfo

