PRODUCT_COPY_FILES += \
    device/redroid/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.enable.native.bridge.exec=1 \
    ro.dalvik.vm.isa.arm64=x86_64 \
    ro.dalvik.vm.native.bridge=libnb.so \
OARD_MESA3D_GALLIUM_DRIVERS += i915 iris crocus
BOARD_MESA3D_VULKAN_DRIVERS += intel intel_hasvk nouveau
BOARD_MESA3D_GALLIUM_VA := enabled
BOARD_MESA3D_VIDEO_CODECS := all