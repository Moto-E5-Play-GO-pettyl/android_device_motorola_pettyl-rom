# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: 2026 elmendezz
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/pettyl

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# ==========================================================
# Architecture (32-bit Userspace / 64-bit Kernel Binder)
# ==========================================================
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_VARIANT_RUNTIME := cortex-a53
TARGET_USES_64_BIT_BINDER := true

# ==========================================================
# Platform & Bootloader
# ==========================================================
TARGET_BOARD_PLATFORM := msm8937
TARGET_BOARD_PLATFORM_GPU := qcom-adreno505
TARGET_BOOTLOADER_BOARD_NAME := msm8937
TARGET_NO_BOOTLOADER := true

# ==========================================================
# Display
# ==========================================================
TARGET_SCREEN_WIDTH := 480
TARGET_SCREEN_HEIGHT := 960

# ==========================================================
# Kernel (Prebuilt)
# ==========================================================
TARGET_NO_KERNEL := false
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel

BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=30 msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 earlycon=msm_hsl_uart,0x78B0000 vmalloc=400M buildvariant=user
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_TAGS_OFFSET := 0x00000100

# VITAL: --header_version 0 fuerza el formato legacy boot.img
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET) \
                        --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
                        --tags_offset $(BOARD_TAGS_OFFSET) \
                        --header_version 0

# ==========================================================
# Partitions & File Systems
# ==========================================================
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1811939328
BOARD_VENDORIMAGE_PARTITION_SIZE := 318767104
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12715015680

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true

# Legacy Partitioning (Non-SAR)
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_SYSTEM := system
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_USES_RECOVERY_AS_BOOT := false
TARGET_NO_RECOVERY := false

# CLEAN SYSTEM FIX: Evitar carpetas root en la particion system
BOARD_ROOT_EXTRA_FOLDERS := 
BOARD_ROOT_EXTRA_SYMLINKS := 

# Bootloader Assertion
TARGET_BOOTLOADER_BOARD_NAME := msm8937

# ==========================================================
# Treble & APEX
# ==========================================================
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current
OVERRIDE_TARGET_FLATTEN_APEX := true

# ==========================================================
# A/B OTA Updater
# ==========================================================
AB_OTA_UPDATER := false

# ==========================================================
# Recovery & Audio
# ==========================================================
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
USE_XML_AUDIO_POLICY_CONF := 1

# ==========================================================
# Security & VINTF
# ==========================================================
VENDOR_SECURITY_PATCH := 2020-07-01
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Inherit Vendor
include vendor/motorola/pettyl/BoardConfigVendor.mk
