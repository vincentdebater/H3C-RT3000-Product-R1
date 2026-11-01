#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh 终极精准锁定版
# ----------------------------------------------------------------

# 1. 直接用 cat 重写 .config，彻底锁定 IPQ50xx 架构与 H3C RW3000 (HW-A) 机型
cat << 'EOF' > .config
CONFIG_TARGET_ipq50xx=y
CONFIG_TARGET_ipq50xx_arm=y
CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y

# 2. 预置 PassWall 运行时必需的内核模块与底层依赖（不编译插件本身）
CONFIG_PACKAGE_kmod-ipt-ipset=y
CONFIG_PACKAGE_kmod-nf-ipset=y
CONFIG_PACKAGE_ipset=y
CONFIG_PACKAGE_iptables-mod-ipset=y
CONFIG_PACKAGE_iptables-mod-tproxy=y
CONFIG_PACKAGE_kmod-ipt-tproxy=y
CONFIG_PACKAGE_dns2socks=y
CONFIG_PACKAGE_microsocks=y
CONFIG_PACKAGE_ipt2socks=y
EOF
