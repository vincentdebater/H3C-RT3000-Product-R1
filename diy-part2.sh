#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh
# 作用：1. 强制指定 IPQ50xx 顶层架构
#       2. 清除默认的 cmcc_rax3000q，精准锁定 H3C RW3000 (HW-A)
#       3. 预置 PassWall 所需内核模块与依赖
# ----------------------------------------------------------------

# 1. 强制指定 IPQ50xx 顶层 Target 与 Subtarget
echo "CONFIG_TARGET_ipq50xx=y" >> .config
echo "CONFIG_TARGET_ipq50xx_arm=y" >> .config

# 2. 强行关闭默认生成的 cmcc_rax3000q 及其他无关机型
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_cmcc_rax3000q=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_cmcc_rax3000q is not set/g' .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000 is not set/g' .config
sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_nx30_hw_d is not set/g' .config

# 3. 精准开启 H3C RW3000 (HW-A) 硬件目标
echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y" >> .config

# 4. 预置 PassWall 所需的内核模块与底层依赖
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-tproxy=y" >> .config
echo "CONFIG_PACKAGE_kmod-ipt-tproxy=y" >> .config
echo "CONFIG_PACKAGE_dns2socks=y" >> .config
echo "CONFIG_PACKAGE_microsocks=y" >> .config
echo "CONFIG_PACKAGE_ipt2socks=y" >> .config
