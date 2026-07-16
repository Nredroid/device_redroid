PRODUCT_COPY_FILES += \
    device/redroid/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
BOARD_MESA3D_GALLIUM_DRIVERS += freedreno v3d vc4 etnaviv nouveau tegra panfrost lima
BOARD_MESA3D_VULKAN_DRIVERS += broadcom freedreno panfrost
BOARD_MESA3D_GALLIUM_VA := disabled
BOARD_MESA3D_VIDEO_CODECS := all