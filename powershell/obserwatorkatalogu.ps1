<#
.NAZWA
    obserwatorkatalogu.ps1

.OPIS
    Obserwuje dany katalog i przesyla z niego pliki txt.

.WYMAGANIA
    - Komputer 
    - Katalog stworzony do obserwowania

.AUTOR
    Mateusz
#>
# Scieżki docelowa i zródlowa można zmieniać
$zrodlo = "C:\pliki"
$cel = "C:\pliki1"

# Sprawdzanie czy scieżka docelowa istnieje, jeśli nie stworzenie jej
if (!(Test-Path -Path $cel)) {
    New-Item -ItemType Directory -Path $cel
}
# Funkcja przenosząca pliki
function Przenies-PlikiTxt {
    param ($sciezkaPliku)

    if ($sciezkaPliku -like "*.txt") {
        $nazwaPliku = [System.IO.Path]::GetFileName($sciezkaPliku)
        $nowaSciezka = Join-Path $cel $nazwaPliku
        Move-Item -Path $sciezkaPliku -Destination $nowaSciezka -Force
        Write-Host "Przeniesiono plik: $nazwaPliku"
    }
}
# Obserwowanie katalogu
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $zrodlo
$watcher.Filter = "*.txt" #tylko pliki txt
$watcher.IncludeSubdirectories = $false # Brak sprawdzania podkatalogów
$watcher.EnableRaisingEvents = $true # Włączenie monitorowania zdarzeń 

Register-ObjectEvent $watcher Created -Action {
    # Opoznienie by plik zdażył się zapisać przed przeniesieniem
    Start-Sleep -Seconds 1
    # Wywołanie funkcji która przenosi plik
    Przenies-PlikiTxt -sciezkaPliku $Event.SourceEventArgs.FullPath
}
# Informacje dla urzytkownika
Write-Host "Monitoring folderu: $zrodlo"
Write-Host "Nacisnij Ctrl+C aby zakonczyc."

# Funkcja dzięki której skrypt się zapętla 
while ($true) {
    Start-Sleep -Seconds 1
}