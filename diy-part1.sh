#!/bin/bash
# ===================================================
# diy-part1.sh (编译前置脚本)
# ===================================================

# 添加 PassWall 软件源及依赖库
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >> feeds.conf.default
echo 'src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages' >> feeds.conf.default
