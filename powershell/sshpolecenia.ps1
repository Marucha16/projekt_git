<#
.NAZWA
    sshpoelecenia

.OPIS
    Pobiera inforamcje z zdalnego hosta za pomocą ssh i zapisuje je do pliku ZdalnyRaport.txt.

.WYMAGANIA
    - Zdalny host
    - Konto mateusz na zdalnym hoscie lub w kodzie mozna zmienic 
    - Skonfigurowane połączenie SSH (klucze lub hasło)

.AUTOR
    Mateusz
#>
# Zapytanie o adres ip
$adresip = Read-Host -Prompt "Podaj swoj adres ip"
# Nazwa zdalnego raportu
$outputFile = "ZdalnyRaport.txt" 
# Pobirenie inforamcji z zdalnego hosta i zapisywanie w pliku
"--------------------------" | Out-File -Encoding utf8 $outputFile
"Podstawowe inforamcje o systemie:" | Out-File -Append -Encoding utf8 $outputFile
ssh mateusz@$adresip "cat /etc/os-release | grep -E '^(NAME|VERSION)='" | Out-File -Append -Encoding utf8 $outputFile
"--------------------------" | Out-File -Append -Encoding utf8 $outputFile
"Pliki ktore zajmuja najwiecej pamieci:" | Out-File -Append -Encoding utf8 $outputFile
ssh mateusz@$adresip "find . -type f -exec du -h {} + | sort -rh | head -n 5" | Out-File -Append -Encoding utf8 $outputFile
"--------------------------" | Out-File -Append -Encoding utf8 $outputFile
"Procesy ktore wykorzystuja najwiecej ramu:" | Out-File -Append -Encoding utf8 $outputFile
ssh mateusz@$adresip "ps -eo pid,comm,%mem --sort=-%mem | head -n 6" | Out-File -Append -Encoding utf8 $outputFile
"--------------------------" | Out-File -Append -Encoding utf8 $outputFile

