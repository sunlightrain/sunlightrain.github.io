#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# 可选：确保 TLS1.2（旧系统常见）
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
} catch {}

$base = "https://wp-content.vmware.com/v2/latest"
$libUrl   = "$base/lib.json"
$itemsUrl = "$base/items.json"

Write-Host -ForegroundColor Cyan "Downloading lib.json"
Invoke-WebRequest -Uri $libUrl -OutFile "lib.json" -UseBasicParsing

Write-Host -ForegroundColor Cyan "Downloading items.json"
Invoke-WebRequest -Uri $itemsUrl -OutFile "items.json" -UseBasicParsing

# 读取并校验 JSON
$itemsJson = Get-Content -Raw -Path "items.json" | ConvertFrom-Json
if (-not $itemsJson -or -not $itemsJson.items) {
    throw "items.json 缺少 'items' 字段或内容为空。"
}

# 简单的非法字符替换函数（目录/文件名）
function Sanitize-Name {
    param([string]$Name)
    if (-not $Name) { return "_empty_" }
    # 替换 Windows 不允许的字符： \ / : * ? " < > |
    $clean = $Name -replace '[\\/:*?"<>|]', '_'
    # 去掉结尾的点或空格，避免 Windows 特殊情况
    $clean = $clean.TrimEnd('.').Trim()
    if ([string]::IsNullOrWhiteSpace($clean)) { $clean = "_unnamed_" }
    return $clean
}

# 简单重试下载函数
function Invoke-DownloadWithRetry {
    param(
        [Parameter(Mandatory=$true)][string]$Uri,
        [Parameter(Mandatory=$true)][string]$OutFile,
        [int]$MaxRetries = 3,
        [int]$DelaySeconds = 2
    )
    for ($i=1; $i -le $MaxRetries; $i++) {
        try {
            Invoke-WebRequest -Uri $Uri -OutFile $OutFile -UseBasicParsing
            return $true
        } catch {
            Write-Host -ForegroundColor Red "下载失败：$Uri（第 $i 次）。错误：$($_.Exception.Message)"
            if ($i -lt $MaxRetries) {
                Start-Sleep -Seconds ($DelaySeconds * [math]::Pow(2, $i-1))
            } else {
                return $false
            }
        }
    }
}

# 处理每个条目
$successCount = 0
$failList = New-Object System.Collections.Generic.List[string]

foreach ($item in $itemsJson.items) {
    $itemName = Sanitize-Name $item.name
    if (-not $itemName) { $itemName = "_unnamed_" }

    # 创建条目目录
    if (!(Test-Path -Path $itemName -PathType Container)) {
        New-Item -ItemType Directory -Path $itemName | Out-Null
        Write-Host -ForegroundColor Cyan "Created directory: $itemName"
    } else {
        Write-Host -ForegroundColor DarkCyan "Directory exists: $itemName"
    }

    # 获取文件列表（兼容不同结构）
    $hrefs = @()
    if ($item.files -and $item.files.hrefs) {
        $hrefs = $item.files.hrefs
    } elseif ($item.hrefs) {
        $hrefs = $item.hrefs
    }

    if (-not $hrefs -or $hrefs.Count -eq 0) {
        Write-Host -ForegroundColor Yellow "条目 '$itemName' 未发现可下载的 hrefs，跳过。"
        continue
    }

    Write-Host -ForegroundColor Cyan "Downloading item: $itemName ($($hrefs.Count) files)"

    foreach ($relPath in $hrefs) {
        if ([string]::IsNullOrWhiteSpace($relPath)) { continue }

        # 仅取文件名部分，避免相对路径穿越；如果需要目录层级，可更细粒度处理
        $fileNameOnly = Sanitize-Name ([System.IO.Path]::GetFileName($relPath))
        if ([string]::IsNullOrWhiteSpace($fileNameOnly)) { $fileNameOnly = "_file_" }

        $destPath = Join-Path -Path $itemName -ChildPath $fileNameOnly
        $downloadUrl = ($relPath -match '^https?://') ? $relPath : "$base/$relPath"

        # 已存在则跳过（也可改为校验大小/哈希）
        if (Test-Path -Path $destPath -PathType Leaf) {
            Write-Host -ForegroundColor DarkYellow "Exists, skip: $destPath"
            continue
        }

        Write-Host -ForegroundColor Yellow "Downloading: $downloadUrl -> $destPath"
        $ok = Invoke-DownloadWithRetry -Uri $downloadUrl -OutFile $destPath -MaxRetries 3 -DelaySeconds 2
        if ($ok) {
            $successCount++
        } else {
            $failList.Add("$downloadUrl -> $destPath")
        }
    }
}

Write-Host -ForegroundColor Green "下载完成，成功文件数：$successCount"
if ($failList.Count -gt 0) {
    Write-Host -ForegroundColor Red "以下文件下载失败："
    $failList | ForEach-Object { Write-Host -ForegroundColor Red "  $_" }
}