#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh 终极锁定版
# ----------------------------------------------------------------

# 1. 强制指定 IPQ50xx 顶层架构（防止回退到默认的 ath79）
echo "CONFIG_TARGET_ipq50xx=y" >> .config
echo "CONFIG_TARGET_ipq50xx_arm=y" >> .config

# 2. 彻底清除其他同架构设备的干扰
sed -i '/_cmcc_rax3000q=y/d' .config
sed -i '/_h3c_rt3000=y/d' .config
sed -i '/_h3c_nx30_hw_d=y/d' .config

# 3. 严格精准锁定 H3C RW3000 (HW-A)
echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y" >> .config

# 4. 预置 PassWall 运行时必需的内核模块与底层依赖（不编译插件本身）
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-tproxy=y" >> .config
echo "CONFIG_PACKAGE_kmod-ipt-tproxy=y" >> .config
echo "CONFIG_PACKAGE_dns2socks=y" >> .config
echo "CONFIG_PACKAGE_microsocks=y" >> .config
echo "CONFIG_PACKAGE_ipt2socks=y" >> .config
