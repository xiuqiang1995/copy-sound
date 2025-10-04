#!/bin/bash

# 初始化一个变量来存储上一次剪贴板内容的哈希值
last_hash=""

while true; do
    # 获取当前剪贴板内容的 MD5 哈希值
    current_hash=$(pbpaste | md5)

    # 如果当前哈希值和上一次的不同
    if [ "$current_hash" != "$last_hash" ]; then
        # 并且上一次的哈希值不是空的 (避免脚本第一次运行时就响)
        if [ -n "$last_hash" ]; then
            # 播放系统声音 'Tink'，这个声音很像“滴”
            afplay /System/Library/Sounds/frog.aiff
        fi
        # 更新哈希值
        last_hash="$current_hash"
    fi

    # 等待 1 秒
    sleep 0.05
done