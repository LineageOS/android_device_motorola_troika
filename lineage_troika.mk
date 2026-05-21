#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

## Inherit from generic products, most specific first
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

## Inherit from troika device
$(call inherit-product, device/motorola/troika/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

## Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## Device identifier, this must come after all inclusions
PRODUCT_DEVICE := troika
PRODUCT_NAME := lineage_troika
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola one action
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

## Use the latest CTS approved build identifiers
PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="troika-user 11 RSBS31.Q1-48-36-23 ef3cf release-keys" \
    BuildFingerprint=motorola/troika_retail/troika_sprout:11/RSBS31.Q1-48-36-23/ef3cf:user/release-keys \
    DeviceName=troika
