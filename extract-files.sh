#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=troika
VENDOR=motorola

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

# Fix proprietary blobs
BLOB_ROOT="$ANDROID_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary

"${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${BLOB_ROOT}"/vendor/lib/sensors.chub.so
"${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${BLOB_ROOT}"/vendor/lib64/sensors.chub.so
"${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${BLOB_ROOT}"/vendor/lib/hw/sensors.troika_sprout.so
"${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${BLOB_ROOT}"/vendor/lib64/hw/sensors.troika_sprout.so

# Remove libhidltransport dependency
"${PATCHELF}" --remove-needed "libhidltransport.so" "${BLOB_ROOT}"/vendor/lib/libril_sitril.so
"${PATCHELF}" --remove-needed "libhidltransport.so" "${BLOB_ROOT}"/vendor/lib64/libril_sitril.so

# Remove libhwbinder dependency
"${PATCHELF}" --remove-needed "libhwbinder.so" "${BLOB_ROOT}"/vendor/lib/libril_sitril.so
"${PATCHELF}" --remove-needed "libhwbinder.so" "${BLOB_ROOT}"/vendor/lib64/libril_sitril.so

"${MY_DIR}/setup-makefiles.sh"
