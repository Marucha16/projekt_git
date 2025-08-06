<#
.NAZWA
    artykuly.ps1

.OPIS
    Pobiera i wyświetla artykuły na podany temat z API serwisu newsapi.org.
    Umożliwia poruszanie się po stronach.

.WYMAGANIA
    - Konto i klucz API z https://newsapi.org , , musisz podać api

.AUTOR
    Mateusz
#>
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$api= # Podaj api
# Zapytanie o temat
$temat = Read-Host -Prompt "Podaj na jaki temat artykul chcesz znalezc"
# Podstawowe zmienne do zapytania
$jezyk = "pl"
$iloscWynikow = 10
# Zaczynamy od 1 strony
$page=1
# Wypisanie wszystkich artykułów
Write-Host "Artykulow jest $($response.totalResults)"
$d=0
# Warunek zakonczenia
while($d -ne 3)
{
# Wypisanie stron
Write-Host "--------"
Write-Host "Strona: $page"
# Wyslanie zapytania
$url = "https://newsapi.org/v2/everything?q=$temat&language=$jezyk&pageSize=$iloscWynikow&sortBy=publishedAt&page=$page&apiKey=$api"
$response = Invoke-RestMethod -Uri $url
# Jesli wszystko okej wypisanie informacji
if ($response.status -eq "ok") {
    $i = 1
    foreach ($article in $response.articles) {
        Write-Host "$i.Tytul $($article.title)"
        Write-Host "   Zrodlo: $($article.source.name)"
        Write-Host "   Link: $($article.url)"
        Write-Host "   Opublikowano: $($article.publishedAt)"
        Write-Host "----------------------"
        $i++
    }
    # W razie błędu poinforamowanie
} else {
    Write-Error "Błąd podczas pobierania danych: $($response.message)"
}
# Zapytanie co chce sie zrobic dalej
$d = Read-Host -Prompt "1-Nastepna strona.
2-Wroc do poprzedniej strony.
3-zakoncz.
Inny numer pozostajesz na stronie na ktorej jestes.
-----------------------------------
Podaj numer w zaleznosc i co chcesz zrobic:"
# W razie ostatniej strony informowanie tego jesli chce przejsc sie dalej
if($d -eq 1)
{
    if($page -eq $([math]::Ceiling($($response.totalResults)/10)))
    {
        Write-Host "Jestes na ostatniej stronie, nie mozesz pojsc dalej"
    }
    # Dalsza strona
    else {
    $page=$page + 1
    }
}
# Tak samo w razie pierwszej strony, w razie cofania
if($d -eq 2)
{
    if($page -eq 1)
    {
        Write-Host "!!!!Jestes na pierwszej stronie nie mozesz sie cofnac, pozostajesz na tej stronie!!!!"
    }
    # Wczesniejsza strona
    else {
        $page=$page - 1
    }
}
# Zakonczenie programu
if($d -eq 3)
{
    Write-Host "!!!Koniec programu!!!"
}
}


