#!/bin/bash
# -*- coding: utf-8 -*-

# 烟神殿AI工具一键安装管理 - yansd666.com
# 支持 Linux / macOS

set -e

# ================================
# 颜色定义
# ================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ================================
# 工具函数
# ================================
print_header() {
    clear
    echo ""
    echo "================================================================================"
    echo ""
    echo "                    ★★★ 烟神殿AI工具一键安装管理 ★★★"
    echo ""
    echo "                           官网: yansd666.com"
    echo ""
    echo "================================================================================"
}

print_sub_header() {
    clear
    echo ""
    echo "========================================"
    echo "  烟神殿AI - $1"
    echo "  官网: yansd666.com"
    echo "========================================"
    echo ""
}

print_ok() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_err() {
    echo -e "${RED}[错误]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[警告]${NC} $1"
}

print_info() {
    echo -e "${CYAN}[*]${NC} $1"
}

press_enter() {
    echo ""
    read -rp "按 Enter 键继续..."
}

# ================================
# 检查 Node.js
# ================================
check_nodejs() {
    if ! command -v node &>/dev/null; then
        print_err "未检测到 Node.js，请先安装 Node.js"
        echo ""
        echo "  安装方式:"
        echo "    Ubuntu/Debian: sudo apt install nodejs npm"
        echo "    CentOS/RHEL:   sudo yum install nodejs npm"
        echo "    macOS:         brew install node"
        echo "    或访问: https://nodejs.org"
        echo ""
        press_enter
        return 1
    fi
    local node_ver
    node_ver=$(node -v)
    print_ok "Node.js 版本: $node_ver"
    return 0
}

# ================================
# 读取密钥输入
# ================================
read_api_key() {
    local prompt="$1"
    local key=""
    while [ -z "$key" ]; do
        read -rp "$prompt" key
        if [ -z "$key" ]; then
            print_err "API密钥不能为空！"
        fi
    done
    echo "$key"
}

# ================================
# 安装 Claude Code
# ================================
install_claude() {
    print_sub_header "安装 Claude Code"

    check_nodejs || return

    echo ""
    claude_api_key=$(read_api_key "请输入你的烟神殿AI Claude API密钥: ")

    echo ""
    print_info "正在安装 Claude Code..."
    npm install -g @anthropic-ai/claude-code@stable || print_warn "安装过程中可能出现问题，请检查错误信息"

    # 创建 .claude 配置目录和 settings.json
    echo ""
    print_info "正在写入配置文件..."
    local claude_dir="$HOME/.claude"
    mkdir -p "$claude_dir"
    print_ok "配置目录: $claude_dir"

    cat > "$claude_dir/settings.json" <<EOF
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "${claude_api_key}",
    "ANTHROPIC_BASE_URL": "https://yansd666.com",
    "API_TIMEOUT_MS": "300000"
  }
}
EOF
    print_ok "settings.json 配置文件创建成功"

    echo ""
    print_ok "Claude Code 安装配置完成！"
    echo ""
    echo "========================================"
    echo "  配置信息:"
    echo "  配置文件: $claude_dir/settings.json"
    echo "  API地址: https://yansd666.com"
    echo "  超时时间: 300000ms"
    echo "========================================"
    echo ""
    echo "请重新打开终端后，输入 claude 即可使用！"

    press_enter
}

# ================================
# 安装 Codex
# ================================
install_codex() {
    print_sub_header "安装 Codex"

    check_nodejs || return

    echo ""
    codex_api_key=$(read_api_key "请输入你的烟神殿AI OpenAI API密钥: ")

    echo ""
    print_info "正在安装 Codex..."
    npm install -g @openai/codex || print_warn "安装过程中可能出现问题，请检查错误信息"

    # 创建配置目录和文件
    local codex_dir="$HOME/.codex"
    mkdir -p "$codex_dir"
    print_ok "配置目录: $codex_dir"

    # 创建 auth.json
    cat > "$codex_dir/auth.json" <<EOF
{"OPENAI_API_KEY": "${codex_api_key}"}
EOF
    print_ok "auth.json 文件创建成功"

    # 创建 config.toml
    cat > "$codex_dir/config.toml" <<EOF
model_provider = "yansd_ai"
model = "gpt-5.3-codex"
model_reasoning_effort = "high"
disable_response_storage = true
preferred_auth_method = "apikey"

[model_providers.yansd_ai]
name = "yansd_ai"
base_url = "https://yansd666.com/v1"
wire_api = "responses"
EOF
    print_ok "config.toml 文件创建成功"

    echo ""
    print_ok "Codex 安装配置完成！"
    echo ""
    echo "========================================"
    echo "  配置信息:"
    echo "  API地址: https://yansd666.com/v1"
    echo "  配置目录: $codex_dir"
    echo "========================================"
    echo ""
    echo "请重新打开终端后，输入 codex 即可使用！"

    press_enter
}

# ================================
# 安装 Gemini CLI
# ================================
install_gemini() {
    print_sub_header "安装 Gemini CLI"

    check_nodejs || return

    echo ""
    gemini_api_key=$(read_api_key "请输入你的烟神殿AI Gemini API密钥: ")

    echo ""
    print_info "正在安装 Gemini CLI..."
    npm install -g @google/gemini-cli || print_warn "安装过程中可能出现问题，请检查错误信息"

    # 设置环境变量
    echo ""
    print_info "正在设置环境变量..."

    # 检测当前 shell 配置文件
    local shell_rc=""
    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "/bin/bash" ] || [ "$SHELL" = "/usr/bin/bash" ]; then
        shell_rc="$HOME/.bashrc"
    else
        shell_rc="$HOME/.profile"
    fi

    # 移除旧的配置（如果存在）
    if [ -f "$shell_rc" ]; then
        sed -i.bak '/^export GOOGLE_GEMINI_BASE_URL=/d' "$shell_rc" 2>/dev/null || true
        sed -i.bak '/^export GEMINI_API_KEY=/d' "$shell_rc" 2>/dev/null || true
    fi

    # 写入新配置
    {
        echo "export GOOGLE_GEMINI_BASE_URL=\"https://yansd666.com\""
        echo "export GEMINI_API_KEY=\"${gemini_api_key}\""
    } >> "$shell_rc"

    # 当前会话也生效
    export GOOGLE_GEMINI_BASE_URL="https://yansd666.com"
    export GEMINI_API_KEY="${gemini_api_key}"

    print_ok "环境变量已写入 $shell_rc"

    echo ""
    print_ok "Gemini CLI 安装配置完成！"
    echo ""
    echo "========================================"
    echo "  配置信息:"
    echo "  API地址: https://yansd666.com"
    echo "  配置文件: $shell_rc"
    echo "========================================"
    echo ""
    echo "请重新打开终端后，输入 gemini 即可使用！"

    press_enter
}

# ================================
# 全部安装
# ================================
install_all() {
    print_sub_header "安装全部工具"

    check_nodejs || return

    echo ""
    echo "请依次输入各工具的API密钥:"
    echo ""
    claude_api_key=$(read_api_key "Claude Code API密钥: ")
    codex_api_key=$(read_api_key "Codex (OpenAI) API密钥: ")
    gemini_api_key=$(read_api_key "Gemini CLI API密钥: ")

    # [1/3] Claude Code
    echo ""
    echo "========================================"
    echo "[1/3] 正在安装 Claude Code..."
    echo "========================================"
    npm install -g @anthropic-ai/claude-code@stable || print_warn "安装过程中可能出现问题"
    local claude_dir="$HOME/.claude"
    mkdir -p "$claude_dir"
    cat > "$claude_dir/settings.json" <<EOF
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "${claude_api_key}",
    "ANTHROPIC_BASE_URL": "https://yansd666.com",
    "API_TIMEOUT_MS": "300000"
  }
}
EOF
    print_ok "Claude Code 配置完成"

    # [2/3] Codex
    echo ""
    echo "========================================"
    echo "[2/3] 正在安装 Codex..."
    echo "========================================"
    npm install -g @openai/codex || print_warn "安装过程中可能出现问题"
    local codex_dir="$HOME/.codex"
    mkdir -p "$codex_dir"
    cat > "$codex_dir/auth.json" <<EOF
{"OPENAI_API_KEY": "${codex_api_key}"}
EOF
    cat > "$codex_dir/config.toml" <<EOF
model_provider = "yansd_ai"
model = "gpt-5.3-codex"
model_reasoning_effort = "high"
disable_response_storage = true
preferred_auth_method = "apikey"

[model_providers.yansd_ai]
name = "yansd_ai"
base_url = "https://yansd666.com/v1"
wire_api = "responses"
EOF
    print_ok "Codex 配置完成"

    # [3/3] Gemini CLI
    echo ""
    echo "========================================"
    echo "[3/3] 正在安装 Gemini CLI..."
    echo "========================================"
    npm install -g @google/gemini-cli || print_warn "安装过程中可能出现问题"

    local shell_rc=""
    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "/bin/bash" ] || [ "$SHELL" = "/usr/bin/bash" ]; then
        shell_rc="$HOME/.bashrc"
    else
        shell_rc="$HOME/.profile"
    fi

    if [ -f "$shell_rc" ]; then
        sed -i.bak '/^export GOOGLE_GEMINI_BASE_URL=/d' "$shell_rc" 2>/dev/null || true
        sed -i.bak '/^export GEMINI_API_KEY=/d' "$shell_rc" 2>/dev/null || true
    fi
    {
        echo "export GOOGLE_GEMINI_BASE_URL=\"https://yansd666.com\""
        echo "export GEMINI_API_KEY=\"${gemini_api_key}\""
    } >> "$shell_rc"
    export GOOGLE_GEMINI_BASE_URL="https://yansd666.com"
    export GEMINI_API_KEY="${gemini_api_key}"
    print_ok "Gemini CLI 配置完成"

    echo ""
    echo "========================================"
    echo "  全部工具安装配置完成！"
    echo "========================================"
    echo ""
    echo "请重新打开终端后使用:"
    echo "  - claude   (Claude Code)"
    echo "  - codex    (Codex)"
    echo "  - gemini   (Gemini CLI)"

    press_enter
}

# ================================
# 升级 Claude Code
# ================================
upgrade_claude() {
    print_sub_header "升级 Claude Code"
    print_info "正在升级 Claude Code..."
    npm update -g @anthropic-ai/claude-code@stable || print_warn "升级过程中可能出现问题"
    echo ""
    print_ok "Claude Code 升级完成！"
    press_enter
}

# ================================
# 升级 Codex
# ================================
upgrade_codex() {
    print_sub_header "升级 Codex"
    print_info "正在升级 Codex..."
    npm update -g @openai/codex || print_warn "升级过程中可能出现问题"
    echo ""
    print_ok "Codex 升级完成！"
    press_enter
}

# ================================
# 升级 Gemini CLI
# ================================
upgrade_gemini() {
    print_sub_header "升级 Gemini CLI"
    print_info "正在升级 Gemini CLI..."
    npm update -g @google/gemini-cli || print_warn "升级过程中可能出现问题"
    echo ""
    print_ok "Gemini CLI 升级完成！"
    press_enter
}

# ================================
# 升级全部
# ================================
upgrade_all() {
    print_sub_header "升级全部工具"
    echo "[1/3] 正在升级 Claude Code..."
    npm update -g @anthropic-ai/claude-code@stable || print_warn "升级过程中可能出现问题"
    echo ""
    echo "[2/3] 正在升级 Codex..."
    npm update -g @openai/codex || print_warn "升级过程中可能出现问题"
    echo ""
    echo "[3/3] 正在升级 Gemini CLI..."
    npm update -g @google/gemini-cli || print_warn "升级过程中可能出现问题"
    echo ""
    print_ok "全部工具升级完成！"
    press_enter
}

# ================================
# 卸载 Claude Code
# ================================
uninstall_claude() {
    print_sub_header "卸载 Claude Code"
    read -rp "确定要卸载 Claude Code 吗？(y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        return
    fi

    echo ""
    print_info "正在卸载 Claude Code..."
    npm uninstall -g @anthropic-ai/claude-code || print_warn "卸载过程中可能出现问题"

    # 删除配置文件
    local claude_dir="$HOME/.claude"
    if [ -f "$claude_dir/settings.json" ]; then
        print_info "正在删除配置文件..."
        rm -f "$claude_dir/settings.json"
        print_ok "settings.json 配置文件已删除"
    fi

    echo ""
    print_ok "Claude Code 卸载完成！"
    press_enter
}

# ================================
# 卸载 Codex
# ================================
uninstall_codex() {
    print_sub_header "卸载 Codex"
    read -rp "确定要卸载 Codex 吗？(y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        return
    fi

    echo ""
    print_info "正在卸载 Codex..."
    npm uninstall -g @openai/codex || print_warn "卸载过程中可能出现问题"

    # 删除配置目录
    local codex_dir="$HOME/.codex"
    if [ -d "$codex_dir" ]; then
        print_info "正在删除配置文件..."
        rm -rf "$codex_dir"
        print_ok "配置文件已删除"
    fi

    echo ""
    print_ok "Codex 卸载完成！"
    press_enter
}

# ================================
# 卸载 Gemini CLI
# ================================
uninstall_gemini() {
    print_sub_header "卸载 Gemini CLI"
    read -rp "确定要卸载 Gemini CLI 吗？(y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        return
    fi

    echo ""
    print_info "正在卸载 Gemini CLI..."
    npm uninstall -g @google/gemini-cli || print_warn "卸载过程中可能出现问题"

    # 清除环境变量
    print_info "正在清除环境变量..."
    local shell_rc=""
    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "/bin/bash" ] || [ "$SHELL" = "/usr/bin/bash" ]; then
        shell_rc="$HOME/.bashrc"
    else
        shell_rc="$HOME/.profile"
    fi

    if [ -f "$shell_rc" ]; then
        sed -i.bak '/^export GOOGLE_GEMINI_BASE_URL=/d' "$shell_rc" 2>/dev/null || true
        sed -i.bak '/^export GEMINI_API_KEY=/d' "$shell_rc" 2>/dev/null || true
        print_ok "环境变量已从 $shell_rc 中移除"
    fi

    unset GOOGLE_GEMINI_BASE_URL 2>/dev/null || true
    unset GEMINI_API_KEY 2>/dev/null || true

    echo ""
    print_ok "Gemini CLI 卸载完成！"
    press_enter
}

# ================================
# 全部卸载
# ================================
uninstall_all() {
    print_sub_header "卸载全部工具"
    read -rp "确定要卸载全部工具吗？(y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        return
    fi

    echo ""
    echo "[1/3] 正在卸载 Claude Code..."
    npm uninstall -g @anthropic-ai/claude-code || print_warn "卸载过程中可能出现问题"
    local claude_dir="$HOME/.claude"
    if [ -f "$claude_dir/settings.json" ]; then
        rm -f "$claude_dir/settings.json"
        print_ok "Claude Code 配置文件已删除"
    fi

    echo ""
    echo "[2/3] 正在卸载 Codex..."
    npm uninstall -g @openai/codex || print_warn "卸载过程中可能出现问题"
    local codex_dir="$HOME/.codex"
    if [ -d "$codex_dir" ]; then
        rm -rf "$codex_dir"
        print_ok "Codex 配置文件已删除"
    fi

    echo ""
    echo "[3/3] 正在卸载 Gemini CLI..."
    npm uninstall -g @google/gemini-cli || print_warn "卸载过程中可能出现问题"

    local shell_rc=""
    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
        shell_rc="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "/bin/bash" ] || [ "$SHELL" = "/usr/bin/bash" ]; then
        shell_rc="$HOME/.bashrc"
    else
        shell_rc="$HOME/.profile"
    fi

    if [ -f "$shell_rc" ]; then
        sed -i.bak '/^export GOOGLE_GEMINI_BASE_URL=/d' "$shell_rc" 2>/dev/null || true
        sed -i.bak '/^export GEMINI_API_KEY=/d' "$shell_rc" 2>/dev/null || true
        print_ok "Gemini CLI 环境变量已清除"
    fi
    unset GOOGLE_GEMINI_BASE_URL 2>/dev/null || true
    unset GEMINI_API_KEY 2>/dev/null || true

    echo ""
    print_ok "全部工具卸载完成！"
    press_enter
}

# ================================
# 安装菜单
# ================================
install_menu() {
    while true; do
        clear
        echo ""
        echo "================================================================================"
        echo "                烟神殿AI - 安装/配置工具 - yansd666.com"
        echo "================================================================================"
        echo ""
        echo "   请选择要安装的工具:"
        echo ""
        echo "       [1] Claude Code  (需要Node.js)"
        echo "       [2] Codex        (需要Node.js)"
        echo "       [3] Gemini CLI   (需要Node.js >= 18)"
        echo "       [4] 全部安装"
        echo "       [0] 返回主菜单"
        echo ""
        echo "================================================================================"
        echo ""
        read -rp "请输入选项 [0-4]: " choice
        case "$choice" in
            1) install_claude ;;
            2) install_codex ;;
            3) install_gemini ;;
            4) install_all ;;
            0) return ;;
            *) print_err "无效选项，请重新输入！"; sleep 1 ;;
        esac
    done
}

# ================================
# 升级菜单
# ================================
upgrade_menu() {
    while true; do
        clear
        echo ""
        echo "================================================================================"
        echo "                  烟神殿AI - 升级工具 - yansd666.com"
        echo "================================================================================"
        echo ""
        echo "   请选择要升级的工具:"
        echo ""
        echo "       [1] Claude Code"
        echo "       [2] Codex"
        echo "       [3] Gemini CLI"
        echo "       [4] 全部升级"
        echo "       [0] 返回主菜单"
        echo ""
        echo "================================================================================"
        echo ""
        read -rp "请输入选项 [0-4]: " choice
        case "$choice" in
            1) upgrade_claude ;;
            2) upgrade_codex ;;
            3) upgrade_gemini ;;
            4) upgrade_all ;;
            0) return ;;
            *) print_err "无效选项，请重新输入！"; sleep 1 ;;
        esac
    done
}

# ================================
# 卸载菜单
# ================================
uninstall_menu() {
    while true; do
        clear
        echo ""
        echo "================================================================================"
        echo "                  烟神殿AI - 卸载工具 - yansd666.com"
        echo "================================================================================"
        echo ""
        echo "   请选择要卸载的工具:"
        echo ""
        echo "       [1] Claude Code"
        echo "       [2] Codex"
        echo "       [3] Gemini CLI"
        echo "       [4] 全部卸载"
        echo "       [0] 返回主菜单"
        echo ""
        echo "================================================================================"
        echo ""
        read -rp "请输入选项 [0-4]: " choice
        case "$choice" in
            1) uninstall_claude ;;
            2) uninstall_codex ;;
            3) uninstall_gemini ;;
            4) uninstall_all ;;
            0) return ;;
            *) print_err "无效选项，请重新输入！"; sleep 1 ;;
        esac
    done
}

# ================================
# 主菜单
# ================================
main_menu() {
    while true; do
        print_header
        echo ""
        echo "   支持工具:"
        echo "        Claude Code  - Anthropic官方AI编程助手"
        echo "        Codex        - OpenAI官方AI编程助手"
        echo "        Gemini CLI   - Google官方AI命令行工具"
        echo ""
        echo "================================================================================"
        echo ""
        echo "   请选择操作:"
        echo ""
        echo "       [1] 安装/配置工具"
        echo "       [2] 升级工具"
        echo "       [3] 卸载工具"
        echo "       [0] 退出程序"
        echo ""
        echo "================================================================================"
        echo ""
        read -rp "请输入选项 [0-3]: " choice
        case "$choice" in
            1) install_menu ;;
            2) upgrade_menu ;;
            3) uninstall_menu ;;
            0)
                clear
                echo ""
                echo "================================================================================"
                echo ""
                echo "                 感谢使用 烟神殿AI 工具管理脚本"
                echo ""
                echo "                       官网: yansd666.com"
                echo ""
                echo "================================================================================"
                echo ""
                exit 0
                ;;
            *) print_err "无效选项，请重新输入！"; sleep 1 ;;
        esac
    done
}

# ================================
# 入口
# ================================
main_menu
