# 运行批处理文件的PowerShell脚本
# 确保UTF-8编码
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 获取当前目录
$currentDir = Get-Location
Write-Host "当前目录: $currentDir"

# 构建批处理文件路径
$batFile = Join-Path -Path $currentDir -ChildPath "commit_and_push.bat"
Write-Host "批处理文件: $batFile"

# 验证文件存在
if (-not (Test-Path $batFile)) {
    Write-Host "错误: 批处理文件不存在!" -ForegroundColor Red
    exit 1
}

# 运行批处理文件
Write-Host "运行批处理文件..."
& cmd.exe /c "$batFile"

if ($LASTEXITCODE -eq 0) {
    Write-Host "批处理文件运行成功!"
} else {
    Write-Host "批处理文件运行失败，退出代码: $LASTEXITCODE"
}