#!/bin/bash

# 1. 追加 PassWall 主程序及依赖包源到 feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >> feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages' >> feeds.conf.default

# 2. 自动写入内核 Netfilter、IPSet 及 PassWall、无线漫游配置到 .config
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config

# 3. 强制指定使用全功能 wpad-openssl 以支持 802.11r/k/v 漫游
echo "CONFIG_PACKAGE_wpad-openssl=y" >> .config
