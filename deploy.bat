@echo off
cd /d "d:\06-参赛作品\归一问题\1\归一问题-自学程序-8.9 - Storyline output"
"C:\Program Files\Git\bin\git.exe" add -A
if %ERRORLEVEL% EQU 0 (
    echo 成功添加文件到暂存区
) else (
    echo 添加文件失败
    exit /b 1
)