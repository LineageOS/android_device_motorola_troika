#
# Copyright (C) 2020 The LineageOS Project
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
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from troika device
$(call inherit-product, device/motorola/troika/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := troika
PRODUCT_NAME := lineage_troika
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := One Action
PRODUCT_MANUFACTURER := Motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

# Use the latest approved GMS identifiers
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=troika_sprout \
    PRIVATE_BUILD_DESC="10/QSBS30.62-29-7/0ea60:user/release-keys"

BUILD_FINGERPRINT := motorola/troika_retail/troika_sprout:10/QSBS30.62-29-7/0ea60:user/release-keys
