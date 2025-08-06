#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的 192.168.10.1 修改成你想要的就可以了
#sed -i 's/192.168.100.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/iStore OS/g' package/base-files/files/bin/config_generate

# ttyd 自动登录
# sed -i "s?/bin/login?/usr/libexec/login.sh?g" ${GITHUB_WORKSPACE}/openwrt/package/feeds/packages/ttyd/files/ttyd.config

# 添加自定义软件包
# echo '
# CONFIG_PACKAGE_luci-app-mosdns=y
# CONFIG_PACKAGE_luci-app-adguardhome=y
# CONFIG_PACKAGE_luci-app-openclash=y
# ' >> .config

echo "CONFIG_PACKAGE_nginx=y
CONFIG_PACKAGE_nginx-ssl=y
CONFIG_PACKAGE_nginx-ssl-util=y
CONFIG_PACKAGE_nginx-util=y
CONFIG_PACKAGE_nginx-mod-luci=y
CONFIG_PACKAGE_luci-nginx=y" >> .config

echo "CONFIG_PACKAGE_luci-app-pppoe-relay=y
CONFIG_PACKAGE_rp-pppoe-relay=y" >> .config

echo "CONFIG_PACKAGE_coremark=y" >> .config
cp -f $GITHUB_WORKSPACE/configfiles/coremark/coremark.sh package/base-files/files/bin/coremark.sh
chmod 755 package/base-files/files/bin/coremark.sh
