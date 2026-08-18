#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: 2026 elmendezz
# SPDX-License-Identifier: Apache-2.0
#

# API levels
PRODUCT_SHIPPING_API_LEVEL := 27

# Health & Symlinks
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service \
    pettyl_symlinks

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# ==========================================================
# ROOTDIR: Archivos forzados al RAMDISK (Evita carpetas root en system.img)
# ==========================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom

# Scripts (.sh) -> Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/bin/apanic_annotate.sh:$(TARGET_COPY_OUT_RAMDISK)/apanic_annotate.sh \
    $(LOCAL_PATH)/rootdir/bin/apanic_copy.sh:$(TARGET_COPY_OUT_RAMDISK)/apanic_copy.sh \
    $(LOCAL_PATH)/rootdir/bin/apanic_save.sh:$(TARGET_COPY_OUT_RAMDISK)/apanic_save.sh \
    $(LOCAL_PATH)/rootdir/bin/hardware_revisions.sh:$(TARGET_COPY_OUT_RAMDISK)/hardware_revisions.sh \
    $(LOCAL_PATH)/rootdir/bin/init.class_main.sh:$(TARGET_COPY_OUT_RAMDISK)/init.class_main.sh \
    $(LOCAL_PATH)/rootdir/bin/init.crda.sh:$(TARGET_COPY_OUT_RAMDISK)/init.crda.sh \
    $(LOCAL_PATH)/rootdir/bin/init.gbmods.sh:$(TARGET_COPY_OUT_RAMDISK)/init.gbmods.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mdm.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mdm.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mmi.audio.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.audio.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mmi.block_perm.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.block_perm.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mmi.boot.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.boot.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mmi.carrier.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.carrier.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mmi.mdlog-getlogs.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.mdlog-getlogs.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mmi.touch.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.touch.sh \
    $(LOCAL_PATH)/rootdir/bin/init.mmi.usb.sh:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.usb.sh \
    $(LOCAL_PATH)/rootdir/bin/init.oem.hw.sh:$(TARGET_COPY_OUT_RAMDISK)/init.oem.hw.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.class_core.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.class_core.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.coex.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.coex.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.crashdata.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.crashdata.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.early_boot.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.early_boot.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.efs.sync.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.efs.sync.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.post_boot.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.post_boot.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.sdio.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.sdio.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.sensors.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.sensors.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.syspart_fixup.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.syspart_fixup.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qcom.wifi.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.wifi.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qti.fm.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qti.fm.sh \
    $(LOCAL_PATH)/rootdir/bin/init.qti.ims.sh:$(TARGET_COPY_OUT_RAMDISK)/init.qti.ims.sh \
    $(LOCAL_PATH)/rootdir/bin/modem_erase_modemst12.sh:$(TARGET_COPY_OUT_RAMDISK)/modem_erase_modemst12.sh \
    $(LOCAL_PATH)/rootdir/bin/pstore_annotate.sh:$(TARGET_COPY_OUT_RAMDISK)/pstore_annotate.sh \
    $(LOCAL_PATH)/rootdir/bin/qca6234-service.sh:$(TARGET_COPY_OUT_RAMDISK)/qca6234-service.sh \
    $(LOCAL_PATH)/rootdir/bin/wlan_carrier_bin.sh:$(TARGET_COPY_OUT_RAMDISK)/wlan_carrier_bin.sh

# Configs (.rc) -> Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.chipset.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.chipset.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.common.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.common.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.debug.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.debug.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.diag.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.diag.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.diag_mdlog.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.diag_mdlog.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.nonab.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.nonab.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.overlay.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.overlay.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.sensor.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.sensor.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.usb.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.usb.rc \
    $(LOCAL_PATH)/rootdir/etc/init.mmi.volte.rc:$(TARGET_COPY_OUT_RAMDISK)/init.mmi.volte.rc \
    $(LOCAL_PATH)/rootdir/etc/init.oem.rc:$(TARGET_COPY_OUT_RAMDISK)/init.oem.rc \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.factory.rc:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.factory.rc \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.rc:$(TARGET_COPY_OUT_RAMDISK)/init.qcom.rc \
    $(LOCAL_PATH)/rootdir/etc/init.target.rc:$(TARGET_COPY_OUT_RAMDISK)/init.target.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/motorola/pettyl/pettyl-vendor.mk)

# Properties
TARGET_PRODUCT_PROP := $(LOCAL_PATH)/system.prop

# Low RAM / Android Go optimizations
$(call inherit-product, build/make/target/product/go_defaults.mk)

# Dalvik heap configuration for 1GB RAM
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# =================================================================
# =================================================================
# =================================================================
# ======================    elmendezz    ==========================
# =================================================================
# =================================================================
# =================================================================
