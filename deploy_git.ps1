# 直接执行Git命令的部署脚本
# 确保UTF-8编码
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

# 初始化Git仓库（如果需要）
if (-not (Test-Path ".git")) {
    Write-Host "初始化Git仓库..."
    & "$gitPath" init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "初始化仓库失败!" -ForegroundColor Red
        exit 1
    }
}

# 添加所有文件
Write-Host "添加文件..."
& "$gitPath" add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "添加文件失败!" -ForegroundColor Red
    exit 1
}

# 提交更改
Write-Host "提交更改..."
& "$gitPath" commit -m "Initial commit"
if ($LASTEXITCODE -ne 0) {
    Write-Host "提交失败 - 可能没有新的更改" -ForegroundColor Yellow
}

# 检查远程仓库
Write-Host "检查远程仓库..."
$remotes = & "$gitPath" remote
if (-not ($remotes -contains "origin")) {
    Write-Host "添加远程仓库..."
    & "$gitPath" remote add origin $remoteUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Host "添加远程仓库失败!" -ForegroundColor Red
        exit 1
    }
}

# 推送更改
Write-Host "推送到GitHub..."
& "$gitPath" push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "推送失败! 请检查您的GitHub凭据和网络连接。" -ForegroundColor Red
    Write-Host "您可以尝试手动运行: $gitPath push -u origin main"
    exit 1
}

Write-Host "部署成功!" -ForegroundColor Green