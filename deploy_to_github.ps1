# 设置UTF-8编码
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 项目路径
$projectPath = "d:\06-参赛作品\归一问题\1\归一问题-自学程序-8.9 - Storyline output"

# Git可执行文件路径 - 使用转义字符确保路径正确解析
$gitPath = "C:\Program Files\Git\bin\git.exe"

# 远程仓库URL
$remoteUrl = "https://github.com/huangyangcheng/-.git"

# 切换到项目目录
Write-Host "正在切换到项目目录..."
Set-Location -Path $projectPath

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
    Write-Host "提交失败" -ForegroundColor Red
    exit 1
}

# 设置远程仓库
Write-Host "正在设置远程仓库..."
& "$gitPath" remote add origin $remoteUrl
if ($LASTEXITCODE -ne 0) {
    Write-Host "设置远程仓库失败，可能已经存在"
}

# 推送到GitHub
Write-Host "正在推送到GitHub..."
& "$gitPath" push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "推送失败" -ForegroundColor Red
    exit 1
}

Write-Host "成功推送到GitHub" -ForegroundColor Green