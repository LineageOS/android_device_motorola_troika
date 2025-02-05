#
# Copyright (C) 2020-2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
