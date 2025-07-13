<#
.NAZWA
ftp2.ps1

.OPIS
Tworzy połączenie i wysyła pliki przez ftp

.WYMAGANIA
-Stworzony dwa foldery pomocny i z kopia 

.AUTOR
Mateusz
#>
function ftp1()
{ 
    # Stworzenie polaczenia i przeslanie pliku
       $ftpFull = "$ftpServer$ftpFolder$(Split-Path $zipsciezka -Leaf)"
        Write-Host "Ścieżka FTP: $ftpFull"
        $webclient = New-Object System.Net.WebClient
        $login = Read-Host -Prompt "Podaj login"
        $haslo = Read-Host -Prompt "Podaj haslo" -AsSecureString
        $secureCred = New-Object System.Management.Automation.PSCredential($login, $haslo)
        $webclient.Credentials = $secureCred.GetNetworkCredential()
        $webclient.UploadFile($ftpFull, $zipsciezka)
}
# Tu wpisuje sie ip
$ftpServer = "ftp://192.168.1.197"         
$ftpFolder = "/ftp/"   
# Podanie gdziew na lokalnym komputerze tworzyc kopie 
$kopia ="/mnt/c/Users/kopia/"
$zip1 = "/mnt/c/Users/pomocna" 
# Kompresja pakowanie do zipa
$zip= "Kopia_{0}.zip" -f (Get-Date -Format "yyyyMMdd_HHmmss")
$zipsciezka = Join-Path -Path $zip1 -ChildPath $zip
Compress-Archive -Path $kopia -DestinationPath $zipsciezka -Force
# Uruchamianie funkcji
ftp1
Get-ChildItem -Path $zip1 -File | Remove-Item -Force