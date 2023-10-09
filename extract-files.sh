#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
    vendor/lib64/camera/components/com.qti.node.watermark.so)
        "${PATCHELF}" --add-needed "libpiex_shim.so" "${2}"
        ;;
    vendor/lib/libsnsdiaglog.so | vendor/lib/libsnsapi.so | vendor/lib64/sensors.ssc.so | vendor/lib64/libsnsdiaglog.so | vendor/lib64/libssc.so | vendor/lib64/libsnsapi.so | vendor/lib64/libsensorcal.so | vendor/bin/sensors.qti)
        "${PATCHELF}" --replace-needed "libprotobuf-cpp-lite-3.9.1.so" "libprotobuf-cpp-full-3.9.1.so" "${2}"
        ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=courbet
export DEVICE_COMMON=sm6150-common
export VENDOR=xiaomi

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
