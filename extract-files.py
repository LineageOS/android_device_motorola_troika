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
    lib_fixup_remove,
    lib_fixup_vendorcompat,
    lib_fixups,
    lib_fixups_user_type,
    libs_proto_3_9_1,
)

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'vendor/motorola/exynos9610-common',
    'hardware/samsung_slsi-linaro/graphics',
]

libs_add_vendor_suffix = (
    'libhwjpeg',
)

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

libs_remove = (
     'libandroidicu',
     'libcsc',
     'libexynosutils',
     'libexynosv4l2',
     'libGrallocWrapper',
)

lib_fixups: lib_fixups_user_type = {
    libs_proto_3_9_1: lib_fixup_vendorcompat,
    libs_add_vendor_suffix: lib_fixup_vendor_suffix,
    libs_remove: lib_fixup_remove,
}

blob_fixups: blob_fixups_user_type = {
    'vendor/lib/libaudioproxy.so': blob_fixup()
        .patchelf_version('0_18')
        .add_needed('libaudioproxy_shim.so'),
    ('vendor/lib/sensors.chub.so', 'vendor/lib/hw/sensors.troika_sprout.so'): blob_fixup()
        .patchelf_version('0_18')
        .replace_needed('libutils.so', 'libutils-v32.so'),
    ('vendor/lib/libril_sitril.so', 'vendor/lib64/libril_sitril.so'): blob_fixup()
        .patchelf_version('0_18')
        .remove_needed('libhidltransport.so')
        .remove_needed('libhwbinder.so'),
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
