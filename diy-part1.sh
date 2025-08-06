#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default
# echo 'src-git adguardhome https://github.com/rufengsuixing/luci-app-adguardhome' >>feeds.conf.default
# echo 'src-git mosdns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
date_version=$(date +"%Y%m%d%H")
echo $date_version > version

Releases_version=$(cat include/version.mk | sed -n 's|.*releases/\([0-9]\+\.[0-9]\+\.[0-9]\+\).*|\1|p')
md5_value=$(wget -qO- "https://mirrors.ustc.edu.cn/openwrt/releases/${Releases_version}/targets/rockchip/armv8/kmods/")
hash_value=$(echo "$md5_value" | sed -n 's/.*6\.6\.93-1-\([0-9a-f]\{32\}\)\/.*/\1/p' | head -1)
hash_value=${hash_value:-$(echo "$md5_value" | sed -n 's/.*\([0-9a-f]\{32\}\)\/.*/\1/p' | head -1)}
if [ -n "$hash_value" ] && [[ "$hash_value" =~ ^[0-9a-f]{32}$ ]]; then
    echo "$hash_value" > .vermagic
    echo "kernel内核md5校验码：$hash_value"
fi
