#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh 源码源头清洗与强制锁定版
# ----------------------------------------------------------------

# 1. 遍历源码中所有可能存在的默认配置文件或模版，把 rax3000q 彻底抹掉
find . -name "defconfig" -o -name "*.config" | while read -f; do
    sed -i 's/CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_cmcc_rax3000q=y/# CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_cmcc_rax3000q is not set/g' "$f"
    sed -i '/_cmcc_rax3000q/d' "$f"
done

# 2. 如果源码的 target 目录有针对各机型的 Makefile 或 target.mk，强制把默认机型改为 h3c_rw3000_hw_a
find target/linux/ipq50xx/ -type f -name "*.mk" -exec sed -i 's/default *cmcc_rax3000q/default h3c_rw3000_hw_a/g' {} +

# 3. 干净利落地写入属于 H3C RW3000 (HW-A) 的终极 .config
cat << 'EOF' > .config
CONFIG_TARGET_ipq50xx=y
CONFIG_TARGET_ipq50xx_arm=y
CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y

# 4. 预置 PassWall 运行时必需的内核模块与底层依赖（不编译插件本身）
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
