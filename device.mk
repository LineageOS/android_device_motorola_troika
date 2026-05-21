#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the common tree
$(call inherit-product, device/motorola/exynos9610-common/common.mk)

# Inherit proprietary files
$(call inherit-product, vendor/motorola/troika/troika-vendor.mk)

# Wi-Fi
PRODUCT_PACKAGES += \
    TroikaWifiOverlay
