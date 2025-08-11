# GitHub Deployment Script
# Ensure UTF-8 encoding
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Git executable path
$gitPath = "C:\Program Files\Git\bin\git.exe"

# Check if Git exists
if (-not (Test-Path $gitPath)) {
    Write-Host "Error: Git not found!" -ForegroundColor Red
    exit 1
}

# Remote repository URL
$remoteUrl = "https://github.com/huangyangcheng/-.git"

# Print current status
Write-Host "Current directory: " (Get-Location)
Write-Host "Git path: $gitPath"
Write-Host "Remote repository: $remoteUrl"

# Initialize Git repository if needed
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..."
    & "$gitPath" init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to initialize repository!" -ForegroundColor Red
        exit 1
    }
}

# Add all files
Write-Host "Adding files..."
& "$gitPath" add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to add files!" -ForegroundColor Red
    exit 1
}

# Commit changes
Write-Host "Committing changes..."
& "$gitPath" commit -m "Initial commit"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Commit failed - no changes to commit" -ForegroundColor Yellow
}

# Check remote repository
Write-Host "Checking remote repository..."
$remotes = & "$gitPath" remote
if (-not ($remotes -contains "origin")) {
    Write-Host "Adding remote repository..."
    & "$gitPath" remote add origin $remoteUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to add remote repository!" -ForegroundColor Red
        exit 1
    }
}

# Push changes
Write-Host "Pushing to GitHub..."
& "$gitPath" push -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "Push failed! Check your GitHub credentials and network connection." -ForegroundColor Red
    Write-Host "You can try running manually: $gitPath push -u origin main"
    exit 1
}

Write-Host "Deployment successful!" -ForegroundColor Green