#!/bin/sh

check_root() {
    if [ "$(id -u)" != "0" ]; then
        echo "错误：此脚本需要Root权限执行！" >&2
        echo "请使用以下命令之一：" >&2
        echo "  1. sudo $0" >&2
        echo "  2. 以root用户身份执行" >&2
        exit 1
    fi
}

check_root

URL="${1:-https://gitee.com/natpierce/luci-app-natpierce/releases/download/v26.6.15/luci-app-natpierce_26.6.15_all.ipk}"
TMP_FILE="/tmp/_natpierce_install.ipk"

echo " 开始一键下载并安装IPK"
echo " 下载链接: $URL"

echo ">> [1/3] 正在下载..."
wget -q --show-progress -O "$TMP_FILE" "$URL" || {
    echo "下载失败！请检查链接或网络。"
    exit 1
}

echo ">> [2/3] 正在安装..."
opkg install "$TMP_FILE" --force-overwrite || {
    echo "安装失败！请查看上方错误信息。"
    rm -f "$TMP_FILE"
    exit 1
}

echo ">> [3/3] 清理安装包..."
rm -f "$TMP_FILE"

echo " 安装成功完成！"