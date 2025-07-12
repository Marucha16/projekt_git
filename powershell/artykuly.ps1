[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$api="afb6c5f2a8cd436ab0d1994e4f3402de"
#zapytanie o temat
$temat = Read-Host -Prompt "Podaj na jaki temat artykul chcesz znalezc"
#podstawowe zmienne do zapytania
$jezyk = "pl"
$iloscWynikow = 10
#zaczynamy od 1 strony
$page=1
#wypisanie wszystkich artykolowe
Write-Host "Artykulow jest $($response.totalResults)"
$d=0
#warunek zakonczenia
while($d -ne 3)
{
#wypisanie stron
Write-Host "--------"
Write-Host "Strona: $page"
#wyslanie zapytania
$url = "https://newsapi.org/v2/everything?q=$temat&language=$jezyk&pageSize=$iloscWynikow&sortBy=publishedAt&page=$page&apiKey=$api"
$response = Invoke-RestMethod -Uri $url
#jesli wszystko okej wypisanie informacji
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
    #w razie bledu poinforamowanie
} else {
    Write-Error "Błąd podczas pobierania danych: $($response.message)"
}
#zapytanie co chce sie zrobic dalej
$d = Read-Host -Prompt "1-Nastepna strona
2-Wroc do poprzedniej strony
3-zakoncz
Inny numer pozostajesz na stronie na ktorej jestes
-----------------------------------
Podaj numer w zaleznosc i co chcesz zrobic"
#w razie ostatniej strony informowanie tego jesli chce przejsc sie dalej
if($d -eq 1)
{
    if($page -eq $([math]::Ceiling($($response.totalResults)/10)))
    {
        Write-Host "Jestes na ostatniej stronie, nie mozesz pojsc dalej"
    }
    #dalsza strona
    else {
    $page=$page + 1
    }
}
#tak samo w razie pierwszej strony, w razie cofania
if($d -eq 2)
{
    if($page -eq 1)
    {
        Write-Host "!!!!Jestes na pierwszej stronie nie mozesz sie cofnac, pozostajesz na tej stronie!!!!"
    }
    #wczesniejsza strona
    else {
        $page=$page - 1
    }
}
#zakonczenie programu
if($d -eq 3)
{
    Write-Host "!!!Koniec programu!!!"
}
}
