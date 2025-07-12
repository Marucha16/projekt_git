<#
.NAZWA
    kurs.ps1

.OPIS
    Skrypt pobiera kurs waluty z ostatnich 5 dni z API NBP.
    W dni wolne wypisuje brak kursu tego dnia

.WYMAGANIA
    - Dostęp do internetu

.AUTOR
    Mateusz

#>
$odp= Read-Host -Prompt "Podaj jakiej waluty kurs chcesz sprawdzic(np zapisz to w sposob PLN lub USD)"
$dzis = (Get-Date).ToString("yyyy-MM-dd")
$dzien1=(Get-Date).AddDays(-5).ToString("yyyy-MM-dd")
#format zapytania
$url="https://api.nbp.pl/api/exchangerates/rates/a/$odp/$dzien1/$dzis/?format=json"
#wyslanie zapytania
$response = Invoke-RestMethod -Uri $url
$d=0
#for ktory przechodzi przez poszczegolne dni
for($i=0;$i -lt 6 ;$i++)
{
    #pbranie daty zaczynajac od 5 dni temu
    $dzien1=(Get-Date).AddDays(-(5-$i)).ToString("yyyy-MM-dd")
    #porownywanie czy napewno dane byly dostepne (w weekend nie dostepne)
    if($dzien1 -eq $($response.rates.effectiveDate[$d]) )
    {
        Write-Host "--------------------"
        Write-Host "Dnia $($response.rates.effectiveDate[$d])" 
        Write-Host "Kurs $odp wynosil $($response.rates.mid[$d]) PLN"
        #wypisywanie zmiany kursu od wczoraj
        iF($d -ne 0 )
        {
            Write-Host "Kurs zmeinil sie od poprzedniego dnia o $($($response.rates.mid[$d])-$($response.rates.mid[$($d-1)])) PLN "
        }
        $d=$d+1
    }
    #wypisywanie jesli dane niedostepne (np w weekend)
    else {
        Write-Host "--------------------"
        Write-Host "Dnia $dzien1"
        Write-Host "Dzien wolny brak kursu"
    }

}

