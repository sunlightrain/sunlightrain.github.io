
<#
SYNOPSIS
  Collect key memory metrics on Windows Server and export CSV/JSON/HTML report.

PARAMETERS
  -OutputFolder: Base output folder (default: current dir).
  -TopN: Top N processes by memory (default: 20).
  -SampleSeconds: Perf counter sample interval seconds (default: 5).
  -Samples: Perf counter sample count (default: 12).

NOTES
  Run with Administrator privilege for complete info.
  Tested on Windows Server 2016/2019/2022.
#>

param(
    [string]$OutputFolder = "",
    [int]$TopN = 20,
    [int]$SampleSeconds = 5,
    [int]$Samples = 12
)

# region Init output
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
if ([string]::IsNullOrWhiteSpace($OutputFolder)) {
    $OutputFolder = Join-Path -Path (Get-Location) -ChildPath ("MemoryReport_" + $timestamp)
} else {
    $OutputFolder = Join-Path -Path $OutputFolder -ChildPath ("MemoryReport_" + $timestamp)
}
New-Item -Path $OutputFolder -ItemType Directory -Force | Out-Null
Write-Host ("Output folder: " + $OutputFolder) -ForegroundColor Cyan
# endregion

# region Save function
function Save-Table {
    param(
        [Parameter(Mandatory=$true)] [string]$Name,
        [Parameter(Mandatory=$true)] [object]$Data
    )
    $csvPath = Join-Path $OutputFolder ($Name + ".csv")
    $jsonPath = Join-Path $OutputFolder ($Name + ".json")
    try {
        $Data | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
        $Data | ConvertTo-Json -Depth 6 | Out-File -FilePath $jsonPath -Encoding UTF8
        Write-Host ("Saved: " + $Name + ".csv / " + $Name + ".json") -ForegroundColor Green
    } catch {
        Write-Warning ("Save " + $Name + " failed: " + $_.Exception.Message)
    }
}
# endregion

# region System memory overview
Write-Host "Collecting system memory overview..." -ForegroundColor Yellow

$os = Get-CimInstance Win32_OperatingSystem
$memPerf = Get-CimInstance -Namespace root\cimv2 -ClassName Win32_PerfFormattedData_PerfOS_Memory

$systemMemoryOverview = [PSCustomObject]@{
    Timestamp                        = (Get-Date)
    ComputerName                     = $env:COMPUTERNAME
    OSVersion                        = $os.Version
    TotalVisibleMemoryMB             = [math]::Round(($os.TotalVisibleMemorySize/1024),2)
    FreePhysicalMemoryMB             = [math]::Round(($os.FreePhysicalMemory/1024),2)
    TotalVirtualMemoryMB             = [math]::Round(($os.TotalVirtualMemorySize/1024),2)
    CommittedBytesMB                 = [math]::Round(($memPerf.CommittedBytes/1MB),2)
    AvailableMBytes                  = $memPerf.AvailableMBytes
    CacheBytesMB                     = [math]::Round(($memPerf.CacheBytes/1MB),2)
    PoolPagedBytesMB                 = [math]::Round(($memPerf.PoolPagedBytes/1MB),2)
    PoolNonpagedBytesMB              = [math]::Round(($memPerf.PoolNonpagedBytes/1MB),2)
    SystemCodeTotalBytesMB           = [math]::Round(($memPerf.SystemCodeTotalBytes/1MB),2)
    SystemDriverTotalBytesMB         = [math]::Round(($memPerf.SystemDriverTotalBytes/1MB),2)
    TransitionPagesRepurposedPerSec  = $memPerf.TransitionPagesRepurposedPerSec
    PagesInputPerSec                 = $memPerf.PagesInputPerSec
    PagesOutputPerSec                = $memPerf.PagesOutputPerSec
}
Save-Table -Name "system_memory_overview" -Data @($systemMemoryOverview)
# endregion

# region Perf counters trend
Write-Host "Collecting perf counters (trend)..." -ForegroundColor Yellow

$counters = @(
    '\Memory\Available MBytes',
    '\Memory\Committed Bytes',
    '\Memory\Cache Bytes',
    '\Memory\Pool Paged Bytes',
    '\Memory\Pool Nonpaged Bytes',
    '\Memory\Pages Input/sec',
    '\Memory\Pages Output/sec',
    '\Process(_Total)\Working Set',
    '\Process(_Total)\Private Bytes'
)

$counterSamples = @()
for ($i=0; $i -lt $Samples; $i++) {
    $result = Get-Counter -Counter $counters -SampleInterval $SampleSeconds -ErrorAction SilentlyContinue
    foreach ($set in $result.CounterSamples) {
        $counterSamples += [PSCustomObject]@{
            Timestamp    = $result.Timestamp.LocalDateTime
            Path         = $set.Path
            InstanceName = $set.InstanceName
            CookedValue  = [math]::Round($set.CookedValue,2)
        }
    }
}
Save-Table -Name "perf_counter_samples" -Data $counterSamples
# endregion

# region Process lists
Write-Host "Collecting top processes..." -ForegroundColor Yellow

$serviceMap = @{}
try {
    Get-WmiObject -Class Win32_Service -ErrorAction Stop | ForEach-Object {
        if ($_.ProcessId -ne 0) {
            $serviceMap[$_.ProcessId] = $_.Name
        }
    }
} catch {
    Write-Warning ("Service map failed: " + $_.Exception.Message)
}

$processes = Get-Process | ForEach-Object {
    $svc = $null
    if ($serviceMap.ContainsKey($_.Id)) { $svc = $serviceMap[$_.Id] }
    [PSCustomObject]@{
        Name                   = $_.ProcessName
        Id                     = $_.Id
        ServiceName            = $svc
        WorkingSetMB           = [math]::Round(($_.WorkingSet/1MB),2)
        PrivateMemorySizeMB    = [math]::Round(($_.PrivateMemorySize/1MB),2)
        PagedMemorySizeMB      = [math]::Round(($_.PagedMemorySize/1MB),2)
        NonpagedSystemMemoryMB = [math]::Round(($_.NonpagedSystemMemorySize/1MB),2)
        VirtualMemorySizeMB    = [math]::Round(($_.VirtualMemorySize/1MB),2)
        Handles                = $_.HandleCount
        Threads                = $_.Threads.Count
        StartTime              = $_.StartTime 2>$null
        CPU                    = $_.CPU
        Path                   = $_.Path
    }
}

$topByWorkingSet = $processes | Sort-Object WorkingSetMB -Descending | Select-Object -First $TopN
$topByPrivate    = $processes | Sort-Object PrivateMemorySizeMB -Descending | Select-Object -First $TopN
$topByVirtual    = $processes | Sort-Object VirtualMemorySizeMB -Descending | Select-Object -First $TopN

Save-Table -Name "top_process_by_workingset" -Data $topByWorkingSet
Save-Table -Name "top_process_by_privatebytes" -Data $topByPrivate
Save-Table -Name "top_process_by_virtualbytes" -Data $topByVirtual
Save-Table -Name "process_full_list" -Data $processes
# endregion

# region Analysis notes (ASCII to avoid encoding issues)
$recommendation = @()
$recommendation += "Working Set: physical memory currently mapped to the process."
$recommendation += "Private Bytes: memory exclusively committed for the process (closer to real usage)."
$recommendation += "If total memory usage is high but process usage looks normal, check: Cache Bytes (file system cache), Pool Nonpaged/Paged (kernel/drivers), SystemDriverTotalBytes."
$recommendation += "If Pool Nonpaged Bytes keeps growing, suspect a driver leak; use WDK PoolMon by tag."
$recommendation += "Trend watch: Committed Bytes vs Available MBytes inverse moves; Pages Input/Output/sec spikes -> memory pressure/paging."

$advice = [PSCustomObject]@{
    Timestamp = (Get-Date)
    Notes     = ($recommendation -join "`n")
}
Save-Table -Name "analysis_notes" -Data @($advice)
# endregion

# region HTML report (use proper here-strings)
Write-Host "Generating HTML report..." -ForegroundColor Yellow

$htmlPath = Join-Path $OutputFolder ("MemoryReport_" + $timestamp + ".html")

# HTML header
$htmlHeader = @"
<html>
<head>
<meta charset="utf-8">
<title>Memory Report $timestamp</title>
<style>
body { font-family: Segoe UI, Arial, sans-serif; margin: 24px; }
table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
th, td { border: 1px solid #ddd; padding: 8px; }
th { background-color: #f4f4f4; }
h1 { border-bottom: 2px solid #333; padding-bottom: 6px; }
h2 { color: #333; }
.small { color: #666; font-size: 12px; }
</style>
</head>
<body>
<h1>Windows Server Memory Report ($timestamp)</h1>
<p class="small">Computer: $($env:COMPUTERNAME) | OS: $($os.Version)</p>
"@

# HTML footer
$htmlFooter = @"
</body>
</html>
"@

$topWsHtml = $topByWorkingSet | ConvertTo-Html -Property Name,Id,ServiceName,WorkingSetMB,PrivateMemorySizeMB,VirtualMemorySizeMB,Handles,Threads -As Table -PreContent "<h2>Top Processes by Working Set</h2>"
$topPvHtml = $topByPrivate    | ConvertTo-Html -Property Name,Id,ServiceName,PrivateMemorySizeMB,WorkingSetMB,VirtualMemorySizeMB,Handles,Threads -As Table -PreContent "<h2>Top Processes by Private Bytes</h2>"
$sysHtml   = $systemMemoryOverview | ConvertTo-Html -As List -PreContent "<h2>System Memory Overview</h2>"
$notesHtml = $recommendation | ConvertTo-Html -As List -PreContent "<h2>Notes & Recommendations</h2>"

$fullHtml = $htmlHeader + $sysHtml + $topWsHtml + $topPvHtml + $notesHtml + $htmlFooter
$fullHtml | Out-File -FilePath $htmlPath -Encoding UTF8

Write-Host ("HTML report generated: " + $htmlPath) -ForegroundColor Green
# endregion

Write-Host ("Done. Files are under: " + $OutputFolder) -ForegroundColor Cyan
