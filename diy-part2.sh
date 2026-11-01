#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh
# 作用：1. 强制声明 IPQ50xx 顶层 Target 与 Subtarget（锁定 RW3000 HW-A）
#       2. 预置 PassWall 运行时必需的所有内核模块与底层依赖
#       3. 保留 QSDK 默认无线驱动组件，确保 mac80211 顺利编译
# ----------------------------------------------------------------

# 1. 强制指定 IPQ50xx 顶层 Target 与 Subtarget（防止 make defconfig 变回 ath79）
echo "CONFIG_TARGET_ipq50xx=y" >> .config
echo "CONFIG_TARGET_ipq50xx_arm=y" >> .config

# 2. 精准开启 H3C RW3000 (HW-A) 硬件目标，关闭其他同系列机型
echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y" >> .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000 is not set/g' .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d is not set/g' .config

# 3. 预置 PassWall 所需的内核模块与底层依赖（确保后期手动安装不报错）
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-tproxy=y" >> .config
echo "CONFIG_PACKAGE_kmod-ipt-tproxy=y" >> .config
echo "CONFIG_PACKAGE_dns2socks=y" >> .config
echo "CONFIG_PACKAGE_microsocks=y" >> .config
echo "CONFIG_PACKAGE_ipt2socks=y" >> .config
