#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

## Inherit from the common tree
include device/motorola/exynos9610-common/BoardConfigCommon.mk

## Inherit from the proprietary configuration
include vendor/motorola/troika/BoardConfigVendor.mk

DEVICE_PATH := device/motorola/troika

## Assert
TARGET_OTA_ASSERT_DEVICE := troika,one_action

## Kernel
TARGET_KERNEL_CONFIG += ext_config/troika.conf

## Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
