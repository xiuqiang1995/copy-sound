# 📋 copy-sound

**再也不用怀疑是否复制成功了！一个为 macOS `Cmd+C` 命令 vibe coding 而来的声音通知。**

---

### 🌟 背景 (Background)

你是否也曾遇到过这样的烦恼：
- 按下 `⌘C`，切换窗口，按下 `⌘V`，结果粘贴出来的却是上一次的内容。
- 为了一个小小的“复制提示音”功能，却要下载一个臃肿的 App，而它 90% 的功能都和 [Raycast](https://www.raycast.com/) 等工具重叠。

在 AI First 的时代，我们解决问题的方式也应随之改变。与其被动地**寻找**一个不完美的工具，不如主动地与 AI 一起**创造**一个完美的解决方案。

`copy-sound` 项目因此诞生。它是一个通过 vibe coding 创造出来的、极简的、完全可定制的剪贴板音效工具。

### ✨ 特点 (Features)

- **极简轻量**: 纯 Shell 脚本，无任何外部依赖，资源消耗极低。
- **高度可定制**: 你可以随意更换提示音效，调整响应灵敏度。
- **稳定运行**: 通过 macOS 的 `launchd` 服务实现开机自启和后台稳定运行。
- **安装/卸载简单**: 提供一键式安装和卸载脚本，绝不污染你的系统。

### 🚀 安装与使用 (Installation & Usage)

1.  将本项目克隆到本地：
    ```bash
    git clone [https://github.com/xiuqiang1995/copy-sound.git](https://github.com/xiuqiang1995/copy-sound.git)
    ```
2.  进入项目目录：
    ```bash
    cd copy-sound
    ```
3.  运行安装脚本：
    ```bash
    bash install.sh
    ```
安装成功！现在你每次复制内容时，都应该能听到“滴”的一声了。

### 🔧 配置 (Configuration)

所有的配置都在核心脚本 `copy_sound.sh` 文件中，你可以根据自己的喜好进行修改：

- **更换提示音**:
  修改 `afplay` 这一行后面的声音文件路径。macOS 自带了很多音效，位于 `/System/Library/Sounds/`。
  ```bash
  # 示例：将声音更换为“潜水艇”
  afplay /System/Library/Sounds/Submarine.aiff
  ```

- **调整灵敏度**:
  修改文件末尾的 `sleep` 值。该值越小，响应越快，但 CPU 占用会略微增加。推荐值为 `0.05`。
  ```bash
  # 示例：将检查间隔改为 0.08 秒
  sleep 0.08
  ```

修改配置后，**需要重新运行一次 `bash install.sh`** 来让更改生效。

### 🗑️ 卸载 (Uninstallation)

如果你不再需要此功能，只需运行卸载脚本即可完全移除。
```bash
bash uninstall.sh
```

### 💡 原理 (How it Works)

本工具通过一个后台循环脚本实现：
1.  每隔一个极短的时间（如 `0.05` 秒），获取当前剪贴板内容的 MD5 哈希值。
2.  与上一次获取的哈希值进行比较。
3.  如果哈希值发生变化，则判定发生了复制操作，调用 macOS 内置的 `afplay` 命令播放提示音。
4.  整个后台脚本通过 `launchd` 服务进行管理，实现开机自启和进程守护。

---

*Made with ❤️ and a little help from AI.*