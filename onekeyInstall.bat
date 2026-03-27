@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title 烟神殿AI工具一键安装管理 - yansd666.com

:menu
cls
echo.
echo ================================================================================
echo.
echo                     ★★★ 烟神殿AI工具一键安装管理 ★★★
echo.
echo                            官网: yansd666.com
echo.
echo ================================================================================
echo.
echo    支持工具:
echo         Claude Code  - Anthropic官方AI编程助手
echo         Codex        - OpenAI官方AI编程助手
echo         Gemini CLI   - Google官方AI命令行工具
echo.
echo ================================================================================
echo.
echo    请选择操作:
echo.
echo        [1] 安装/配置工具
echo        [2] 升级工具
echo        [3] 卸载工具
echo        [0] 退出程序
echo.
echo ================================================================================
echo.
set /p "choice=请输入选项 [0-3]: "

if "%choice%"=="1" goto install_menu
if "%choice%"=="2" goto upgrade_menu
if "%choice%"=="3" goto uninstall_menu
if "%choice%"=="0" goto end
echo.
echo [错误] 无效选项，请重新输入！
timeout /t 2 >nul
goto menu

:: ================================
:: 安装菜单
:: ================================
:install_menu
cls
echo.
echo ================================================================================
echo                 烟神殿AI - 安装/配置工具 - yansd666.com
echo ================================================================================
echo.
echo    请选择要安装的工具:
echo.
echo        [1] Claude Code  (需要Node.js)
echo        [2] Codex        (需要Node.js)
echo        [3] Gemini CLI   (需要Node.js ^>= 18)
echo        [4] 全部安装
echo        [0] 返回主菜单
echo.
echo ================================================================================
echo.
set /p "install_choice=请输入选项 [0-4]: "

if "%install_choice%"=="1" goto install_claude
if "%install_choice%"=="2" goto install_codex
if "%install_choice%"=="3" goto install_gemini
if "%install_choice%"=="4" goto install_all
if "%install_choice%"=="0" goto menu
echo.
echo [错误] 无效选项，请重新输入！
timeout /t 2 >nul
goto install_menu

:: ================================
:: 升级菜单
:: ================================
:upgrade_menu
cls
echo.
echo ================================================================================
echo                   烟神殿AI - 升级工具 - yansd666.com
echo ================================================================================
echo.
echo    请选择要升级的工具:
echo.
echo        [1] Claude Code
echo        [2] Codex
echo        [3] Gemini CLI
echo        [4] 全部升级
echo        [0] 返回主菜单
echo.
echo ================================================================================
echo.
set /p "upgrade_choice=请输入选项 [0-4]: "

if "%upgrade_choice%"=="1" goto upgrade_claude
if "%upgrade_choice%"=="2" goto upgrade_codex
if "%upgrade_choice%"=="3" goto upgrade_gemini
if "%upgrade_choice%"=="4" goto upgrade_all
if "%upgrade_choice%"=="0" goto menu
echo.
echo [错误] 无效选项，请重新输入！
timeout /t 2 >nul
goto upgrade_menu

:: ================================
:: 卸载菜单
:: ================================
:uninstall_menu
cls
echo.
echo ================================================================================
echo                   烟神殿AI - 卸载工具 - yansd666.com
echo ================================================================================
echo.
echo    请选择要卸载的工具:
echo.
echo        [1] Claude Code
echo        [2] Codex
echo        [3] Gemini CLI
echo        [4] 全部卸载
echo        [0] 返回主菜单
echo.
echo ================================================================================
echo.
set /p "uninstall_choice=请输入选项 [0-4]: "

if "%uninstall_choice%"=="1" goto uninstall_claude
if "%uninstall_choice%"=="2" goto uninstall_codex
if "%uninstall_choice%"=="3" goto uninstall_gemini
if "%uninstall_choice%"=="4" goto uninstall_all
if "%uninstall_choice%"=="0" goto menu
echo.
echo [错误] 无效选项，请重新输入！
timeout /t 2 >nul
goto uninstall_menu

:: ================================
:: 安装 Claude Code
:: ================================
:install_claude
cls
echo.
echo ========================================
echo   烟神殿AI - 安装 Claude Code
echo   官网: yansd666.com
echo ========================================
echo.

:: 检查 Node.js
call :check_nodejs
if %errorlevel% neq 0 goto install_menu

:: 输入 API Key
echo.
set /p "claude_api_key=请输入你的烟神殿AI Claude API密钥: "

if "%claude_api_key%"=="" (
    echo.
    echo [错误] API密钥不能为空！
    pause
    goto install_menu
)

:: 安装 Claude Code
echo.
echo [*] 正在安装 Claude Code...
call npm install -g @anthropic-ai/claude-code@stable



if %errorlevel% neq 0 (
    echo.
    echo [警告] 安装过程中可能出现问题，请检查错误信息
)

:: 创建 .claude 配置目录和 settings.json
echo.
echo [*] 正在写入配置文件...
set "claude_dir=%USERPROFILE%\.claude"

if not exist "%claude_dir%" (
    mkdir "%claude_dir%"
    echo [OK] 配置目录创建成功: %claude_dir%
) else (
    echo [OK] 配置目录已存在: %claude_dir%
)

set "settings_file=%claude_dir%\settings.json"
(
echo {
echo   "env": {
echo     "ANTHROPIC_AUTH_TOKEN": "%claude_api_key%",
echo     "ANTHROPIC_BASE_URL": "https://yansd666.com",
echo     "API_TIMEOUT_MS": "300000"
echo   }
echo }
) > "%settings_file%"
echo [OK] settings.json 配置文件创建成功

echo.
echo [OK] Claude Code 安装配置完成！
echo.
echo ========================================
echo   配置信息:
echo   配置文件: %claude_dir%\settings.json
echo   API地址: https://yansd666.com
echo   超时时间: 300000ms
echo ========================================
echo.
echo 请重新打开终端后，输入 claude 即可使用！
echo.
pause
goto install_menu

:: ================================
:: 安装 Codex
:: ================================
:install_codex
cls
echo.
echo ========================================
echo   烟神殿AI - 安装 Codex
echo   官网: yansd666.com
echo ========================================
echo.

:: 检查 Node.js
call :check_nodejs
if %errorlevel% neq 0 goto install_menu

:: 输入 API Key
echo.
set /p "codex_api_key=请输入你的烟神殿AI OpenAI API密钥: "

if "%codex_api_key%"=="" (
    echo.
    echo [错误] API密钥不能为空！
    pause
    goto install_menu
)

:: 安装 Codex
echo.
echo [*] 正在安装 Codex...
call npm install -g @openai/codex

if %errorlevel% neq 0 (
    echo.
    echo [警告] 安装过程中可能出现问题，请检查错误信息
)

:: 创建配置目录和文件
set "codex_dir=%USERPROFILE%\.codex"

if not exist "%codex_dir%" (
    mkdir "%codex_dir%"
    echo [OK] 配置目录创建成功: %codex_dir%
) else (
    echo [OK] 配置目录已存在: %codex_dir%
)

:: 创建 auth.json
set "auth_file=%codex_dir%\auth.json"
echo {"OPENAI_API_KEY": "%codex_api_key%"} > "%auth_file%"
echo [OK] auth.json 文件创建成功

:: 创建 config.toml
set "config_file=%codex_dir%\config.toml"
(
echo model_provider = "yansd_ai"
echo model = "gpt-5.3-codex"
echo model_reasoning_effort = "high"
echo disable_response_storage = true
echo preferred_auth_method = "apikey"
echo.
echo [model_providers.yansd_ai]
echo name = "yansd_ai"
echo base_url = "https://yansd666.com/v1"
echo wire_api = "responses"
) > "%config_file%"
echo [OK] config.toml 文件创建成功

echo.
echo [OK] Codex 安装配置完成！
echo.
echo ========================================
echo   配置信息:
echo   API地址: https://yansd666.com/v1
echo   配置目录: %codex_dir%
echo ========================================
echo.
echo 请重新打开终端后，输入 codex 即可使用！
echo.
pause
goto install_menu

:: ================================
:: 安装 Gemini CLI
:: ================================
:install_gemini
cls
echo.
echo ========================================
echo   烟神殿AI - 安装 Gemini CLI
echo   官网: yansd666.com
echo ========================================
echo.

:: 检查 Node.js
call :check_nodejs
if %errorlevel% neq 0 goto install_menu

:: 输入 API Key
echo.
set /p "gemini_api_key=请输入你的烟神殿AI Gemini API密钥: "

if "%gemini_api_key%"=="" (
    echo.
    echo [错误] API密钥不能为空！
    pause
    goto install_menu
)

:: 安装 Gemini CLI
echo.
echo [*] 正在安装 Gemini CLI...
call npm install -g @google/gemini-cli

if %errorlevel% neq 0 (
    echo.
    echo [警告] 安装过程中可能出现问题，请检查错误信息
)

REM Set user environment variables
echo.
echo [*] Setting user environment variables...
setx GOOGLE_GEMINI_BASE_URL "https://yansd666.com"
setx GEMINI_API_KEY "%gemini_api_key%"

REM Set system environment variables
echo [*] Setting system environment variables...
setx GOOGLE_GEMINI_BASE_URL "https://yansd666.com" /M 2>nul
setx GEMINI_API_KEY "%gemini_api_key%" /M 2>nul

echo.
echo [OK] Gemini CLI 安装配置完成！
echo.
echo ========================================
echo   配置信息:
echo   API地址: https://yansd666.com
echo ========================================
echo.
echo 请重新打开终端后，输入 gemini 即可使用！
echo.
pause
goto install_menu

:: ================================
:: 全部安装
:: ================================
:install_all
cls
echo.
echo ========================================
echo   烟神殿AI - 安装全部工具
echo   官网: yansd666.com
echo ========================================
echo.

:: 检查 Node.js
call :check_nodejs
if %errorlevel% neq 0 goto install_menu

:: 输入各个 API Key
echo.
echo 请依次输入各工具的API密钥:
echo.
set /p "claude_api_key=Claude Code API密钥: "
set /p "codex_api_key=Codex (OpenAI) API密钥: "
set /p "gemini_api_key=Gemini CLI API密钥: "

:: 安装 Claude Code
echo.
echo ========================================
echo [1/3] 正在安装 Claude Code...
echo ========================================
call npm install -g @anthropic-ai/claude-code@stable


if not "%claude_api_key%"=="" (
    set "claude_dir=%USERPROFILE%\.claude"
    if not exist "!claude_dir!" mkdir "!claude_dir!"
    (
    echo {
    echo   "env": {
    echo     "ANTHROPIC_AUTH_TOKEN": "%claude_api_key%",
    echo     "ANTHROPIC_BASE_URL": "https://yansd666.com",
    echo     "API_TIMEOUT_MS": "300000"
    echo   }
    echo }
    ) > "!claude_dir!\settings.json"
    echo [OK] Claude Code 配置完成
)

:: 安装 Codex
echo.
echo ========================================
echo [2/3] 正在安装 Codex...
echo ========================================
call npm install -g @openai/codex
if not "%codex_api_key%"=="" (
    set "codex_dir=%USERPROFILE%\.codex"
    if not exist "!codex_dir!" mkdir "!codex_dir!"
    echo {"OPENAI_API_KEY": "%codex_api_key%"} > "!codex_dir!\auth.json"
    (
    echo model_provider = "yansd_ai"
    echo model = "gpt-5.3-codex"
    echo model_reasoning_effort = "high"
    echo disable_response_storage = true
    echo preferred_auth_method = "apikey"
    echo.
    echo [model_providers.yansd_ai]
    echo name = "yansd_ai"
    echo base_url = "https://yansd666.com/v1"
    echo wire_api = "responses"
    ) > "!codex_dir!\config.toml"
    echo [OK] Codex 配置完成
)

:: 安装 Gemini CLI
echo.
echo ========================================
echo [3/3] 正在安装 Gemini CLI...
echo ========================================
call npm install -g @google/gemini-cli
if not "%gemini_api_key%"=="" (
    setx GOOGLE_GEMINI_BASE_URL "https://yansd666.com"
    setx GEMINI_API_KEY "%gemini_api_key%"
    setx GOOGLE_GEMINI_BASE_URL "https://yansd666.com" /M 2>nul
    setx GEMINI_API_KEY "%gemini_api_key%" /M 2>nul
    echo [OK] Gemini CLI 配置完成
)

echo.
echo ========================================
echo   全部工具安装配置完成！
echo ========================================
echo.
echo 请重新打开终端后使用:
echo   - claude   (Claude Code)
echo   - codex    (Codex)
echo   - gemini   (Gemini CLI)
echo.
pause
goto menu

:: ================================
:: 升级 Claude Code
:: ================================
:upgrade_claude
cls
echo.
echo ========================================
echo   烟神殿AI - 升级 Claude Code
echo   官网: yansd666.com
echo ========================================
echo.
echo [*] 正在升级 Claude Code...
call npm update -g @anthropic-ai/claude-code@stable


echo.
echo [OK] Claude Code 升级完成！
echo.
pause
goto upgrade_menu

:: ================================
:: 升级 Codex
:: ================================
:upgrade_codex
cls
echo.
echo ========================================
echo   烟神殿AI - 升级 Codex
echo   官网: yansd666.com
echo ========================================
echo.
echo [*] 正在升级 Codex...
call npm update -g @openai/codex
echo.
echo [OK] Codex 升级完成！
echo.
pause
goto upgrade_menu

:: ================================
:: 升级 Gemini CLI
:: ================================
:upgrade_gemini
cls
echo.
echo ========================================
echo   烟神殿AI - 升级 Gemini CLI
echo   官网: yansd666.com
echo ========================================
echo.
echo [*] 正在升级 Gemini CLI...
call npm update -g @google/gemini-cli
echo.
echo [OK] Gemini CLI 升级完成！
echo.
pause
goto upgrade_menu

:: ================================
:: 全部升级
:: ================================
:upgrade_all
cls
echo.
echo ========================================
echo   烟神殿AI - 升级全部工具
echo   官网: yansd666.com
echo ========================================
echo.
echo [1/3] 正在升级 Claude Code...
call npm update -g @anthropic-ai/claude-code@stable


echo.
echo [2/3] 正在升级 Codex...
call npm update -g @openai/codex
echo.
echo [3/3] 正在升级 Gemini CLI...
call npm update -g @google/gemini-cli
echo.
echo [OK] 全部工具升级完成！
echo.
pause
goto menu

:: ================================
:: 卸载 Claude Code
:: ================================
:uninstall_claude
cls
echo.
echo ========================================
echo   烟神殿AI - 卸载 Claude Code
echo   官网: yansd666.com
echo ========================================
echo.
set /p "confirm=确定要卸载 Claude Code 吗？(Y/N): "
if /i not "%confirm%"=="Y" goto uninstall_menu

echo.
echo [*] 正在卸载 Claude Code...
call npm uninstall -g @anthropic-ai/claude-code@stable



:: 删除 .claude 配置文件
set "claude_dir=%USERPROFILE%\.claude"
if exist "%claude_dir%\settings.json" (
    echo [*] 正在删除配置文件...
    del /f /q "%claude_dir%\settings.json"
    echo [OK] settings.json 配置文件已删除
)

echo.
echo [OK] Claude Code 卸载完成！
echo.
pause
goto uninstall_menu

:: ================================
:: 卸载 Codex
:: ================================
:uninstall_codex
cls
echo.
echo ========================================
echo   烟神殿AI - 卸载 Codex
echo   官网: yansd666.com
echo ========================================
echo.
set /p "confirm=确定要卸载 Codex 吗？(Y/N): "
if /i not "%confirm%"=="Y" goto uninstall_menu

echo.
echo [*] 正在卸载 Codex...
call npm uninstall -g @openai/codex

:: 删除配置文件
set "codex_dir=%USERPROFILE%\.codex"
if exist "%codex_dir%" (
    echo [*] 正在删除配置文件...
    rmdir /s /q "%codex_dir%"
    echo [OK] 配置文件已删除
)

echo.
echo [OK] Codex 卸载完成！
echo.
pause
goto uninstall_menu

:: ================================
:: 卸载 Gemini CLI
:: ================================
:uninstall_gemini
cls
echo.
echo ========================================
echo   烟神殿AI - 卸载 Gemini CLI
echo   官网: yansd666.com
echo ========================================
echo.
set /p "confirm=确定要卸载 Gemini CLI 吗？(Y/N): "
if /i not "%confirm%"=="Y" goto uninstall_menu

echo.
echo [*] 正在卸载 Gemini CLI...
call npm uninstall -g @google/gemini-cli

REM Clear user environment variables
echo [*] Clearing user environment variables...
reg delete "HKCU\Environment" /v GOOGLE_GEMINI_BASE_URL /f 2>nul
reg delete "HKCU\Environment" /v GEMINI_API_KEY /f 2>nul

REM Clear system environment variables
echo [*] Clearing system environment variables...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v GOOGLE_GEMINI_BASE_URL /f 2>nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v GEMINI_API_KEY /f 2>nul

echo.
echo [OK] Gemini CLI 卸载完成！
echo.
pause
goto uninstall_menu

:: ================================
:: 全部卸载
:: ================================
:uninstall_all
cls
echo.
echo ========================================
echo   烟神殿AI - 卸载全部工具
echo   官网: yansd666.com
echo ========================================
echo.
set /p "confirm=确定要卸载全部工具吗？(Y/N): "
if /i not "%confirm%"=="Y" goto uninstall_menu

echo.
echo [1/3] 正在卸载 Claude Code...
call npm uninstall -g @anthropic-ai/claude-code@stable


:: 删除 .claude 配置文件
set "claude_dir=%USERPROFILE%\.claude"
if exist "%claude_dir%\settings.json" (
    del /f /q "%claude_dir%\settings.json"
    echo [OK] Claude Code 配置文件已删除
)

echo.
echo [2/3] 正在卸载 Codex...
call npm uninstall -g @openai/codex
set "codex_dir=%USERPROFILE%\.codex"
if exist "%codex_dir%" rmdir /s /q "%codex_dir%"

echo.
echo [3/3] 正在卸载 Gemini CLI...
call npm uninstall -g @google/gemini-cli
REM Clear user environment variables
reg delete "HKCU\Environment" /v GOOGLE_GEMINI_BASE_URL /f 2>nul
reg delete "HKCU\Environment" /v GEMINI_API_KEY /f 2>nul
REM Clear system environment variables
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v GOOGLE_GEMINI_BASE_URL /f 2>nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v GEMINI_API_KEY /f 2>nul

echo.
echo [OK] 全部工具卸载完成！
echo.
pause
goto menu

:: ================================
:: 检查 Node.js
:: ================================
:check_nodejs
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Node.js，请先安装 Node.js
    echo.
    echo 下载地址: https://nodejs.org
    echo.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node -v') do (
    echo [OK] Node.js 版本: %%i
)
exit /b 0

:: ================================
:: 退出
:: ================================
:end
cls
echo.
echo ================================================================================
echo.
echo                  感谢使用 烟神殿AI 工具管理脚本
echo.
echo                        官网: yansd666.com
echo.
echo ================================================================================
echo.
timeout /t 3 >nul
exit /b 0
