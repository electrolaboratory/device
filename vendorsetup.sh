#!/bin/bash

export TZ=Asia/Jakarta

# Removing
rm -rf device/asus/sdm660-common
rm -rf kernel/asus
rm -rf vendor/asus
#rm -rf lineage/scripts

## Cloning
git clone --depth=1 https://github.com/sotodrom/device_common -b inf device/asus/sdm660-common
git clone --depth=1 https://github.com/sotodrom/kernel_qcom_sdm660 -b newcam --single-branch kernel/asus/sdm660
git clone --depth=1 https://github.com/sotodrom/vendor_asus -b np vendor/asus
#git clone --depth=1 https://github.com/LineageOS/scripts lineage/scripts

## Integrate KernelSU
cd kernel/asus/sdm660
curl -LSs "https://raw.githubusercontent.com/Sorayukii/KernelSU-Next/stable/kernel/setup.sh" | bash -s hookless
cd -

#### signing
rm -rf vendor/infinity-priv/keys
mkdir -p vendor/infinity-priv/keys
sed -i 's|PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/lineage-priv/keys/testkey|PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/infinity-priv/keys/releasekey|g' lineage/scripts/lineage-priv-template/keys.mk
cp -R lineage/scripts/lineage-priv-template/* vendor/infinity-priv/keys/
cd vendor/infinity-priv/keys
bash keys.sh
cd -
