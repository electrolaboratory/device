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
git clone --depth=1 https://github.com/sotodrom/device_common -b inf device/asus/sdm660-common
git clone --depth=1 https://github.com/sotodrom/kernel_qcom_sdm660 -b newcam --single-branch kernel/asus/sdm660
git clone --depth=1 https://github.com/sotodrom/vendor_asus vendor/asus

git clone https://github.com/Kyura-Ground/android_hardware_qcom_audio hardware/qcom-caf/sdm660/audio
git clone https://github.com/Kyura-Ground/android_hardware_qcom_display hardware/qcom-caf/sdm660/display
git clone https://github.com/Kyura-Ground/android_hardware_lineage_interfaces hardware/lineage/interfaces

## Integrate KernelSU
cd kernel/asus/sdm660
curl -LSs "https://raw.githubusercontent.com/Sorayukii/KernelSU-Next/stable/kernel/setup.sh" | bash -s hookless
cd -

#### signing
rm -rf vendor/lineage-priv/keys
mkdir -p vendor/lineage-priv/keys
sed -i 's|PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/lineage-priv/keys/testkey|PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/lineage-priv/keys/releasekey|g' lineage/scripts/lineage-priv-template/keys.mk
cp -R lineage/scripts/lineage-priv-template/* vendor/lineage-priv/keys/
cd vendor/lineage-priv/keys
bash keys.sh
cd -
