# 1. 启用 H3C RT3000 硬件目标
echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rt3000=y" >> .config

# 2. 引入 PassWall 依赖源及主程序
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >> feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages' >> feeds.conf.default
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config

# 3. 启用内核级 ipset 及相关依赖（PassWall 运行必需）
echo "CONFIG_PACKAGE_kmod-ipt-ipset=y" >> .config
echo "CONFIG_PACKAGE_kmod-nf-ipset=y" >> .config
echo "CONFIG_PACKAGE_ipset=y" >> .config
echo "CONFIG_PACKAGE_iptables-mod-ipset=y" >> .config

# 4. 替换无线加密包：禁用精简版，启用支持 802.11r/k/v 漫游的全功能 wpad-openssl
sed -i 's/CONFIG_PACKAGE_wpad-basic-wolfssl=y/# CONFIG_PACKAGE_wpad-basic-wolfssl is not set/g' .config
echo "CONFIG_PACKAGE_wpad-openssl=y" >> .config
