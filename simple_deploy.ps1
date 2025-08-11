# 简易GitHub部署脚本
# 确保使用UTF-8编码
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Git可执行文件路径
$gitPath = "C:\Program Files\Git\bin\git.exe"

# 检查Git是否存在
if (-not (Test-Path $gitPath)) {
    Write-Host "错误: 未找到Git!" -ForegroundColor Red
    exit 1
}

# 远程仓库URL
$remoteUrl = "https://github.com/huangyangcheng/-.git"

# 打印当前状态
Write-Host "当前目录: " (Get-Location)
Write-Host "Git路径: $gitPath"
Write-Host "远程仓库: $remoteUrl"

# 初始化Git仓库
if (-not (Test-Path ".git")) {
    Write-Host "初始化Git仓库..."
    & $gitPath init
}

# 添加所有文件
Write-Host "添加文件..."
& $gitPath add .

# 提交更改
Write-Host "提交更改..."
& $gitPath commit -m "Initial commit"

# 添加远程仓库
Write-Host "设置远程仓库..."
& $gitPath remote add origin $remoteUrl 2>$null

# 推送更改
Write-Host "推送到GitHub..."
& $gitPath push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "部署成功!"
} else {
    Write-Host "部署失败，请手动运行以下命令:"
    Write-Host "$gitPath push -u origin main"
    exit 1
}