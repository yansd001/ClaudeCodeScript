@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 显示欢迎信息
echo ========================================
echo       烟神殿 Claude Code 安装程序
echo ========================================
echo.

:: 提示用户输入API密钥
set /p "API_KEY=请输入您的烟神殿API密钥（将用于替换'sk-...'部分）: "

:: 验证输入是否为空
if "%API_KEY%"=="" (
    echo.
    echo 错误：API密钥不能为空！
    pause
    exit /b 1
)

:: 安装Claude Code
echo.
echo 正在安装Claude Code...
call npm install -g @anthropic-ai/claude-code@stable



if %errorLevel% neq 0 (
    echo.
    echo 警告：npm安装过程中可能出现问题，请检查Node.js是否已正确安装
    echo.
)

:: 创建 .claude 配置目录和 settings.json
echo.
echo 正在配置 Claude Code...
set "claude_dir=%USERPROFILE%\.claude"

if not exist "%claude_dir%" (
    mkdir "%claude_dir%"
    echo [OK] 配置目录创建成功: %claude_dir%
) else (
    echo [OK] 配置目录已存在: %claude_dir%
)

:: 写入 settings.json
set "settings_file=%claude_dir%\settings.json"
(
echo {
echo   "env": {
echo     "ANTHROPIC_AUTH_TOKEN": "%API_KEY%",
echo     "ANTHROPIC_BASE_URL": "https://yansd666.com",
echo     "API_TIMEOUT_MS": "300000"
echo   }
echo }
) > "%settings_file%"
echo [OK] settings.json 配置文件创建成功

:: 完成提示
echo.
echo ========================================
echo           安装完成！
echo ========================================
echo.
set "msg1=  [*] 配置文件: %claude_dir%\settings.json"
set "msg2=  [*] API地址: https://yansd666.com"
set "msg3=  [*] 超时时间: 300000ms"
set "msg4=  1. 请确保API令牌分组已切换到Claude Code专属分组"
set "msg5=  2. 请重新打开终端后，输入 claude 即可使用"
set "msg6=  3. 视频中提到的纯AZ分组已不兼容，API令牌分组请使用Claude Code专属分组"
echo.
echo !msg1!
echo !msg2!
echo !msg3!
echo.
echo [重要提示]
echo !msg4!
echo !msg5!
echo !msg6!
echo.
echo 按任意键退出...
pause >nul