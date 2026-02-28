#!/bin/bash

export TZ=Asia/Jakarta

# Removing
rm -rf device/asus/sdm660-common
rm -rf kernel/asus
rm -rf vendor/asus
rm -rf lineage/scripts

## Cloning
git clone --depth=1 https://github.com/electrolaboratory/common -b 16 device/asus/sdm660-common
git clone --depth=1 https://github.com/sotodrom/kernel_asus_sdm660-4.19 -b 16 --single-branch kernel/asus/sdm660
git clone --depth=1 https://github.com/electrolaboratory/vendor_asus vendor/asus
git clone --depth=1 https://github.com/LineageOS/scripts lineage/scripts

## Integrate KernelSU
cd kernel/asus/sdm660
curl -LSs "https://raw.githubusercontent.com/Sorayukii/KernelSU-Next/stable/kernel/setup.sh" | bash -s hookless
cd -

#### signing
rm -rf vendor/afterlife-priv/keys
mkdir -p vendor/afterlife-priv/keys
sed -i 's|PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/lineage-priv/keys/testkey|PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/afterlife-priv/keys/releasekey|g' lineage/scripts/lineage-priv-template/keys.mk
cp -R lineage/scripts/lineage-priv-template/* vendor/afterlife-priv/keys/
cd vendor/afterlife-priv/keys
bash keys.sh
cd -
