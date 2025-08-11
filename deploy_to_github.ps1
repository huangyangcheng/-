# 设置UTF-8编码
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Git可执行文件路径
$gitPath = "C:\Program Files\Git\bin\git.exe"

# 远程仓库URL
$remoteUrl = "https://github.com/huangyangcheng/-.git"

# 确保在正确的目录中 - 使用当前目录而不是硬编码路径
Write-Host "确保在项目目录中..."
$currentDir = Get-Location
Write-Host "当前目录: $currentDir"

# 添加所有文件到暂存区
Write-Host "正在添加文件到暂存区..."
& "$gitPath" add -A
if ($LASTEXITCODE -ne 0) {
    Write-Host "添加文件失败" -ForegroundColor Red
    exit 1
}

# 提交更改
Write-Host "正在提交更改..."
& "$gitPath" commit -m "Initial commit of Storyline3 courseware"
if ($LASTEXITCODE -ne 0) {
    Write-Host "提交失败 - 可能没有需要提交的更改" -ForegroundColor Yellow
    # 不退出，继续尝试推送
}

# 检查远程仓库是否已存在
Write-Host "检查远程仓库是否已存在..."
$remoteExists = & "$gitPath" remote | Select-String -Pattern "origin"
if (-not $remoteExists) {
    Write-Host "正在设置远程仓库..."
    & "$gitPath" remote add origin $remoteUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Host "设置远程仓库失败" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "远程仓库已存在，跳过设置"
}

# 推送到GitHub
Write-Host "正在推送到GitHub..."
& "$gitPath" push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "推送失败 - 请检查您的GitHub凭据和网络连接"
    Write-Host "您可以尝试手动运行以下命令:"
    Write-Host "$gitPath push -u origin main"
    exit 1
}

Write-Host "成功推送到GitHub" -ForegroundColor Green