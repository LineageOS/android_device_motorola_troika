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

# Camera
$(call soong_config_set,exynos_camera,front_camera_sensor,SENSOR_NAME_OV12A10FF)
$(call soong_config_set,exynos_camera,back_camera_sensor,SENSOR_NAME_OV12A10)
$(call soong_config_set,exynos_camera,back_1_camera_sensor,SENSOR_NAME_S5K5E9)
$(call soong_config_set,exynos_camera,back_2_camera_sensor,SENSOR_NAME_OV16885C)
$(call soong_config_set,exynos_camera,target_variant,troika)

## Kernel
TARGET_KERNEL_CONFIG := troika_defconfig

## Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
