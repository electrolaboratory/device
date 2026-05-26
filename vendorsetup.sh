#!/bin/bash

export TZ=Asia/Jakarta

# Removing
rm -rf device/asus/sdm660-common
rm -rf kernel/asus
rm -rf vendor/asus
rm -rf hardware/lineage/interfaces
rm -rf hardware/qcom-caf/sdm660/audio
rm -rf hardware/qcom-caf/sdm660/display

## Cloning
git clone --depth=1 https://github.com/electrolaboratory/common -b ax device/asus/sdm660-common
git clone --depth=1 https://github.com/rsuntk/android_kernel_asus_sdm660-4.19 -b lineage-23.2 --single-branch kernel/asus/sdm660
git clone --depth=1 https://github.com/electrolaboratory/vendor_asus -b 16 vendor/asus

git clone https://github.com/Kyura-Ground/android_hardware_qcom_audio hardware/qcom-caf/sdm660/audio
git clone https://github.com/Kyura-Ground/android_hardware_qcom_display hardware/qcom-caf/sdm660/display
git clone https://github.com/Kyura-Ground/android_hardware_lineage_interfaces hardware/lineage/interfaces

## Integrate KernelSU
cd kernel/asus/sdm660
curl -LSs "https://raw.githubusercontent.com/rsuntk/KernelSU/main/kernel/setup.sh" | bash -s staging/xxksu
cd -
