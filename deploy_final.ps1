# 最终部署脚本 - 修复语法错误
# 设置UTF-8编码
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 检查Git是否可用
$gitPath = "C:\Program Files\Git\bin\git.exe"
if (-not (Test-Path $gitPath)) {
    Write-Host "未找到Git可执行文件: $gitPath" -ForegroundColor Red
    exit 1
}
Write-Host "Git可执行文件: $gitPath"

# 远程仓库URL
$remoteUrl = "https://github.com/huangyangcheng/-.git"
Write-Host "远程仓库URL: $remoteUrl"

# 确保在正确的目录中
$currentDir = Get-Location
Write-Host "当前目录: $currentDir"

# 检查是否在Git仓库中
$gitStatus = & $gitPath status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "不在Git仓库中或Git命令执行失败: $gitStatus" -ForegroundColor Red
    # 尝试初始化仓库
    Write-Host "尝试初始化Git仓库..."
    & $gitPath init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "初始化仓库失败" -ForegroundColor Red
        exit 1
    }
    Write-Host "仓库初始化成功"
}

# 添加所有文件到暂存区
Write-Host "正在添加文件到暂存区..."
& $gitPath add -A
if ($LASTEXITCODE -ne 0) {
    Write-Host "添加文件失败" -ForegroundColor Red
    # 显示详细错误信息
    $errorMsg = & $gitPath add -A 2>&1
    Write-Host "错误详情: $errorMsg"
    exit 1
}
Write-Host "文件添加成功"

# 提交更改
Write-Host "正在提交更改..."
& $gitPath commit -m "Initial commit of Storyline3 courseware"
if ($LASTEXITCODE -ne 0) {
    Write-Host "提交失败 - 可能没有需要提交的更改" -ForegroundColor Yellow
    # 显示详细错误信息
    $errorMsg = & $gitPath commit -m "Initial commit" 2>&1
    Write-Host "错误详情: $errorMsg"
}

# 检查并设置远程仓库
Write-Host "检查远程仓库..."
$remoteExists = & $gitPath remote | Select-String -Pattern "origin"
if (-not $remoteExists) {
    Write-Host "设置远程仓库..."
    & $gitPath remote add origin $remoteUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Host "设置远程仓库失败" -ForegroundColor Red
        $errorMsg = & $gitPath remote add origin $remoteUrl 2>&1
        Write-Host "错误详情: $errorMsg"
        exit 1
    }
    Write-Host "远程仓库设置成功"
} else {
    Write-Host "远程仓库已存在"
}

# 推送到GitHub
Write-Host "正在推送到GitHub..."
& $gitPath push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "推送失败 - 请检查GitHub凭据和网络连接" -ForegroundColor Red
    $errorMsg = & $gitPath push -u origin main 2>&1
    Write-Host "错误详情: $errorMsg"
    Write-Host "手动运行: $gitPath push -u origin main"
    exit 1
}

Write-Host "成功推送到GitHub" -ForegroundColor Green