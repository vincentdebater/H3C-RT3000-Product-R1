#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh
# ----------------------------------------------------------------

# 1. 强制指定 IPQ50xx 顶层 Target 与 Subtarget
echo "CONFIG_TARGET_ipq50xx=y" >> .config
echo "CONFIG_TARGET_ipq50xx_arm=y" >> .config

# 2. 锁定 H3C RW3000 (HW-A) 硬件目标，关闭其他机型
echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y" >> .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000 is not set/g' .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d is not set/g' .config

# 3. 预置 PassWall 所需内核模块与依赖（不编译插件本体）
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-tproxy=y" >> .config
echo "CONFIG_PACKAGE_kmod-ipt-tproxy=y" >> .config
echo "CONFIG_PACKAGE_dns2socks=y" >> .config
echo "CONFIG_PACKAGE_microsocks=y" >> .config
echo "CONFIG_PACKAGE_ipt2socks=y" >> .config

# 4. 选用 wpad-openssl 启用 802.11r/k/v 漫游（温和替换模式）
echo "CONFIG_PACKAGE_wpad-basic=n" >> .config
echo "CONFIG_PACKAGE_wpad-basic-wolfssl=n" >> .config
echo "CONFIG_PACKAGE_wpad-openssl=y" >> .config
