#!/bin/bash
# ----------------------------------------------------------------
# diy-part2.sh - 强制覆盖并绝对锁定 RW3000
# ----------------------------------------------------------------

# 如果根目录下存在我们刚才写好的 custom.config，直接复制为正式的 .config 覆盖
if [ -f "$GITHUB_WORKSPACE/custom.config" ]; then
    cp -f $GITHUB_WORKSPACE/custom.config .config
    echo "成功加载自定义的 custom.config 配置文件！"
else
    # 兜底强制写入
    echo "CONFIG_TARGET_ipq50xx=y" > .config
    echo "CONFIG_TARGET_ipq50xx_arm=y" >> .config
    echo "CONFIG_TARGET_DEVICE_ipq50xx_arm_DEVICE_h3c_rw3000_hw_a=y" >> .config
fi
