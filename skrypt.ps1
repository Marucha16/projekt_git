$zrodlo = "C:\pliki"
$cel = "C:\pliki1"

if (!(Test-Path -Path $cel)) {
    New-Item -ItemType Directory -Path $cel
}

function Przenies-PlikiTxt {
    param ($sciezkaPliku)

    if ($sciezkaPliku -like "*.txt") {
        $nazwaPliku = [System.IO.Path]::GetFileName($sciezkaPliku)
        $nowaSciezka = Join-Path $cel $nazwaPliku
        Move-Item -Path $sciezkaPliku -Destination $nowaSciezka -Force
        Write-Host "Przeniesiono plik: $nazwaPliku"
    }
}

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $zrodlo
$watcher.Filter = "*.txt"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent $watcher Created -Action {
    Start-Sleep -Seconds 1
    Przenies-PlikiTxt -sciezkaPliku $Event.SourceEventArgs.FullPath
}

Write-Host "Monitoring folderu: $zrodlo"
Write-Host "Nacisnij Ctrl+C aby zakonczyc."

while ($true) {
    Start-Sleep -Seconds 1
}