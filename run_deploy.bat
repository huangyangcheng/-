@echo off
chcp 65001 > nul

:: 直接使用完整路径运行批处理文件
call "d:\06-参赛作品\归一问题\1\归一问题-自学程序-8.9 - Storyline output\commit_and_push.bat"

if %ERRORLEVEL% EQU 0 (
    echo 批处理文件运行成功
) else (
    echo 批处理文件运行失败，错误代码: %ERRORLEVEL%
    pause
)