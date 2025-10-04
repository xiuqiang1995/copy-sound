#!/bin/bash

# --- 配置 ---
# 服务名称，确保唯一
SERVICE_NAME="com.my.copysound"
# 脚本安装目录
INSTALL_DIR="$HOME/.local/bin"
# 脚本文件名
SCRIPT_NAME="copy_sound.sh"
# LaunchAgent plist 文件路径
PLIST_FILE="$HOME/Library/LaunchAgents/$SERVICE_NAME.plist"

# --- 脚本开始 ---
echo "🚀 开始安装剪贴板提示音脚本..."

# 确保安装目录存在
mkdir -p "$INSTALL_DIR"
echo "✅ 目录 $INSTALL_DIR 已准备就绪。"

# 将核心脚本复制到安装目录
cp "$(dirname "$0")/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
# 赋予脚本执行权限
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
echo "✅ 核心脚本已安装到 $INSTALL_DIR/$SCRIPT_NAME"

# 创建 LaunchAgent plist 文件，用于开机自启和后台运行
echo "📝 正在创建自启动配置文件..."
cat > "$PLIST_FILE" << EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$SERVICE_NAME</string>
    <key>ProgramArguments</key>
    <array>
        <string>$INSTALL_DIR/$SCRIPT_NAME</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOL
echo "✅ 配置文件已创建于 $PLIST_FILE"

# 加载服务，让它立即开始运行
# 先尝试卸载旧的，防止重复加载出错
launchctl unload "$PLIST_FILE" 2>/dev/null
launchctl load "$PLIST_FILE"
echo "✅ 服务已加载并开始在后台运行。"

echo "🎉 安装完成！现在你每次复制内容时，应该都能听到'滴'的一声了。"
echo "💡 如果想卸载，请运行同一目录下的 uninstall.sh 脚本。"