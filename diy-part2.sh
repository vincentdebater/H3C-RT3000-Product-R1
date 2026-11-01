#!/bin/bash
# 1. 启用 H3C RW3000 (HW-A) 硬件目标，并关闭其他同系列机型以节省编译时间
echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y" >> .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000 is not set/g' .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d is not set/g' .config

# 2. 启用 PassWall 插件主程序
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config

# 3. 启用 PassWall 依赖的内核级 ipset 模块
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config

# 4. 替换无线加密包：禁用精简版，启用支持 802.11r/k/v 漫游的全功能 wpad-openssl
sed -i 's/CONFIG_PACKAGE_wpad-basic-wolfssl=y/# CONFIG_PACKAGE_wpad-basic-wolfssl is not set/g' .config
echo "CONFIG_PACKAGE_wpad-openssl=y" >> .config
