#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh
# 作用：1. 锁定 RW3000 (HW-A) 硬件目标并关闭其他同系列机型
#       2. 不内置 PassWall 插件，但完整预置其所需的内核模块与依赖
#       3. 强制替换为支持 802.11r/k/v 漫游的 wpad-openssl
# ----------------------------------------------------------------

# 1. 精准开启 H3C RW3000 (HW-A) 硬件目标，关闭其他同系列机型
echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y" >> .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000 is not set/g' .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d is not set/g' .config

# 2. 预置 PassWall 所需的内核模块与底层依赖（不编译 luci-app-passwall 界面插件）
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-tproxy=y" >> .config
echo "CONFIG_PACKAGE_kmod-ipt-tproxy=y" >> .config
echo "CONFIG_PACKAGE_dns2socks=y" >> .config
echo "CONFIG_PACKAGE_microsocks=y" >> .config
echo "CONFIG_PACKAGE_ipt2socks=y" >> .config

# 3. 核心：替换无线加密组件，强制启用 wpad-openssl 以完整支持 802.11r/k/v 漫游
sed -i 's/CONFIG_PACKAGE_wpad-basic-wolfssl=y/# CONFIG_PACKAGE_wpad-basic-wolfssl is not set/g' .config
sed -i 's/CONFIG_PACKAGE_wpad-basic=y/# CONFIG_PACKAGE_wpad-basic is not set/g' .config
echo "CONFIG_PACKAGE_wpad-openssl=y" >> .config
