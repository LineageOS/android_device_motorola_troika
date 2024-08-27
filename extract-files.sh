#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        # Missing libutils symbols
        vendor/lib*/sensors.chub.so|vendor/lib*/hw/sensors.troika_sprout.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
            ;;
        # Remove libhidltransport/libhwbinder dependencies
        vendor/lib*/libril_sitril.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libhidltransport.so" "${2}"
            "${PATCHELF}" --remove-needed "libhwbinder.so" "${2}"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=troika
export DEVICE_COMMON=exynos9610-common
export VENDOR=motorola
export VENDOR_COMMON=${VENDOR}

"./../../${VENDOR_COMMON}/${DEVICE_COMMON}/extract-files.sh" "$@"
