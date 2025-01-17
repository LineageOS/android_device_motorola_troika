#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)

from extract_utils.fixups_lib import (
    lib_fixup_vendorcompat,
    lib_fixups_user_type,
    libs_proto_3_9_1,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'vendor/motorola/exynos9610-common',
    'device/motorola/exynos9610-common',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/exynos/gralloc3',
    'hardware/samsung_slsi-linaro/graphics',
]

lib_fixups: lib_fixups_user_type = {
    libs_proto_3_9_1: lib_fixup_vendorcompat,
}

blob_fixups: blob_fixups_user_type = {
    ('vendor/lib/sensors.chub.so', 'vendor/lib64/sensors.chub.so', 'vendor/lib/hw/sensors.troika_sprout.so', 'vendor/lib64/hw/sensors.troika_sprout.so'): blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'troika',
    'motorola',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    add_firmware_proprietary_file=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(module, 'exynos9610-common', module.vendor)
    utils.run()
