@echo off
chcp 65001 > nul
cd /d "d:\06-参赛作品\归一问题\1\归一问题-自学程序-8.9 - Storyline output"

:: 添加所有文件到暂存区
"C:\Program Files\Git\bin\git.exe" add -A
if %ERRORLEVEL% NEQ 0 (
    echo 添加文件失败
    exit /b 1
)

:: 提交更改
"C:\Program Files\Git\bin\git.exe" commit -m "Initial commit of Storyline3 courseware"
if %ERRORLEVEL% NEQ 0 (
    echo 提交失败
    exit /b 1
)

:: 设置远程仓库（首次推送时需要）
"C:\Program Files\Git\bin\git.exe" remote add origin https://github.com/huangyangcheng/-.git
if %ERRORLEVEL% NEQ 0 (
    echo 设置远程仓库失败，可能已经存在
)

:: 推送到GitHub
"C:\Program Files\Git\bin\git.exe" push -u origin main
if %ERRORLEVEL% NEQ 0 (
    echo 推送失败
    exit /b 1
)

echo 成功推送到GitHub