# 烟神殿AI工具一键安装管理脚本

一键安装、升级、卸载 Claude Code / Codex / Gemini CLI，自动配置 API Key，开箱即用。

官网: [yansd666.com](https://yansd666.com)

---

## 支持工具

| 工具 | 厂商 | 说明 |
|------|------|------|
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | Anthropic | AI 编程助手，安装后终端输入 `claude` 使用 |
| [Codex](https://github.com/openai/codex) | OpenAI | AI 编程助手，安装后终端输入 `codex` 使用 |
| [Gemini CLI](https://github.com/google/gemini-cli) | Google | AI 命令行工具，安装后终端输入 `gemini` 使用 |

## 功能一览

- **安装/配置** — 通过 npm 全局安装工具，自动写入 API Key 和配置文件
- **升级** — 一键升级已安装的工具到最新版
- **卸载** — 卸载工具并清除配置文件、环境变量

---

## 快速开始

### Windows

双击运行 `onekeyInstall.bat`，或在 CMD / PowerShell 中执行：

```bat
onekeyInstall.bat
```

### Linux / macOS

**方式一：** 下载后运行

```bash
curl -fsSL https://raw.githubusercontent.com/yansd001/ClaudeCodeScript/main/onekeyInstall.sh -o onekeyInstall.sh
chmod +x onekeyInstall.sh
./onekeyInstall.sh
```

**方式二：** 一行命令直接执行

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yansd001/ClaudeCodeScript/main/onekeyInstall.sh)
```

运行后会进入交互菜单，按提示选择 安装 / 升级 / 卸载 即可。

---

## 脚本说明

### `onekeyInstall.bat` — Windows 一键管理脚本

综合管理脚本，提供交互式菜单，支持对三个工具（Claude Code、Codex、Gemini CLI）进行安装、升级、卸载操作。

- 安装时自动检查 Node.js 环境
- 安装时提示输入 API 密钥，自动写入对应配置文件
- 卸载时清理配置文件和环境变量

### `onekeyInstall.sh` — Linux / macOS 一键管理脚本

与 Windows 版功能完全一致的 Shell 脚本，额外特性：

- 自动检测 Shell 类型（bash / zsh），环境变量写入正确的 rc 文件
- 带颜色终端输出
- 支持 macOS 和主流 Linux 发行版

### `install_claude.bat` — Windows Claude Code 单独安装脚本

仅安装 Claude Code 的精简脚本：

1. 提示输入烟神殿 API 密钥
2. 通过 `npm install -g @anthropic-ai/claude-code@stable` 全局安装
3. 在 `%USERPROFILE%\.claude\` 下创建 `settings.json`，写入 API Key、API 地址和超时配置

配置文件示例：
```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "你的API密钥",
    "ANTHROPIC_BASE_URL": "https://yansd666.com",
    "API_TIMEOUT_MS": "300000"
  }
}
```

### `Codex.bat` — Windows Codex 单独安装脚本

仅安装 Codex 的精简脚本：

1. 提示输入 OpenAI API Key
2. 在 `%USERPROFILE%\.codex\` 下创建配置文件：
   - `auth.json` — 存储 API Key
   - `config.toml` — 模型、API 地址等配置

配置文件示例：
```toml
model_provider = "yansd_ai"
model = "gpt-5.3-codex"
base_url = "https://yansd666.com/v1"
```

---

## 各工具配置文件位置

| 工具 | 配置路径 | 主要文件 |
|------|----------|----------|
| Claude Code | `~/.claude/` | `settings.json` |
| Codex | `~/.codex/` | `auth.json`、`config.toml` |
| Gemini CLI | Shell rc 文件 | 环境变量 `GEMINI_API_KEY`、`GOOGLE_GEMINI_BASE_URL` |

> Windows 下 `~` 即 `%USERPROFILE%`（通常为 `C:\Users\你的用户名`）

---

## 环境要求

- **Node.js** >= 18
- **npm**（随 Node.js 一起安装）
- 系统：Windows / Linux / macOS

Node.js 下载: [https://nodejs.org](https://nodejs.org)

---

## 常见问题

**Q: 安装命令报 `npm: command not found`**
A: 请先安装 Node.js，npm 会随之一起安装。

**Q: Linux 下运行 `onekeyInstall.sh` 报权限错误**
A: 执行 `chmod +x onekeyInstall.sh` 添加执行权限，或使用 `bash onekeyInstall.sh` 直接运行。

**Q: 全局安装 npm 包报权限不足**
A: Linux/macOS 下可使用 `sudo ./onekeyInstall.sh`，或配置 npm 全局目录到用户目录下。

**Q: 安装后输入命令提示找不到**
A: 请关闭当前终端并重新打开，使环境变量和 PATH 生效。
