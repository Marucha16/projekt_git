<#
.NAZWA
    podstinfopw.ps1

.OPIS
    Podstawowe informacje o komputerze, pamięć, ram, nazwa, system opercyjny

.WYMAGANIA
    - komputer

.AUTOR
    Mateusz
#>
function Get-Hostname {
    Write-Host "Hostname: $env:COMPUTERNAME"
}

function Get-OSName {
    $os = Get-CimInstance Win32_OperatingSystem
    Write-Host "OS: $($os.Caption)"
}

function Get-RAMUsage {
    $os = Get-CimInstance Win32_OperatingSystem
    $total = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    $free = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $used = [math]::Round($total - $free, 2)

    Write-Host "RAM użyta: $used GB"
    Write-Host "RAM wolna: $free GB"
    Write-Host "RAM całkowita: $total GB"
}

function Get-DiskUsage {
    $drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"
    foreach ($drive in $drives) {
        $size = [math]::Round($drive.Size / 1GB, 2)
        $free = [math]::Round($drive.FreeSpace / 1GB, 2)
        $used = [math]::Round($size - $free, 2)
        Write-Host "Dysk $($drive.DeviceID): użyto $used GB / $size GB (wolne: $free GB)"
    }
}
Get-Hostname
Get-OSName
Get-RAMUsage
Get-DiskUsage