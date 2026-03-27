@echo off
setlocal enabledelayedexpansion

:input_api_key
set /p "api_key=Please enter OpenAI API Key: "
if "%api_key%"=="" (
    echo API Key cannot be empty, please re-enter!
    goto input_api_key
)

rem Get user profile path
set "user_profile=%USERPROFILE%"
set "codex_dir=%user_profile%\.codex"

rem Create .codex folder
if not exist "%codex_dir%" (
    mkdir "%codex_dir%"
    echo Folder created: %codex_dir%
) else (
    echo Folder already exists: %codex_dir%
)

rem Create auth.json file
set "auth_file=%codex_dir%\auth.json"
echo {"OPENAI_API_KEY": "%api_key%"} > "%auth_file%"
echo auth.json file created

rem Create config.toml file
set "config_file=%codex_dir%\config.toml"
(
echo model_provider = "api111"
echo model = "gpt-5.3-codex"
echo model_reasoning_effort = "high"
echo disable_response_storage = true
echo preferred_auth_method = "apikey"
echo.
echo [model_providers.api111]
echo name = "api111"
echo base_url = "https://yansd666.com/v1"
echo wire_api = "responses"
) > "%config_file%"
echo config.toml file created

echo.
echo Setup completed successfully!
echo Files location: %codex_dir%
echo.
pause