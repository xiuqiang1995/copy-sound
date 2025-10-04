#!/bin/bash

# --- 配置 ---
SERVICE_NAME="com.my.copysound"
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="copy_sound.sh"
PLIST_FILE="$HOME/Library/LaunchAgents/$SERVICE_NAME.plist"

# --- 脚本开始 ---
echo "🗑️ 开始卸载剪贴板提示音脚本..."

# 停止并卸载服务
if [ -f "$PLIST_FILE" ]; then
    launchctl unload "$PLIST_FILE"
    rm "$PLIST_FILE"
    echo "✅ 自启动服务已卸载。"
else
    echo "🤷‍ 自启动服务文件未找到，可能已被卸载。"
fi

# 删除核心脚本
if [ -f "$INSTALL_DIR/$SCRIPT_NAME" ]; then
    rm "$INSTALL_DIR/$SCRIPT_NAME"
    echo "✅ 核心脚本文件已删除。"
else
    echo "🤷‍ 核心脚本文件未找到。"
fi

echo "✅ 卸载完成！"