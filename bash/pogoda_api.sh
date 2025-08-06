#!/bin/bash
# Nazwa: pogoda_api.sh
# Opis: Pobiera pogode z api z openweathermap
# Autor: Mateusz
# Wymagania: bash, curl, jq, sed, iconv, enscript, ghostscript, musisz podać api

read -p "Podaj miasto, w którym chcesz sprawdzic pogode:" city
api= # Podaj api
#pobiernie inforamcji o prognozie na 5 dni
pogoda=$(curl -s "http://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$api" | jq '[.list[] | select(.dt_txt | contains("12:00:00"))]')
prognoza_count=$(echo "$pogoda" | jq 'length')
#pobiernie aktualnej pogody
dzis=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$api")
#tak naprawde wypisywanmie wszystkiego i zapisywanie do pliku txt
echo "Aktualna pogoda w "$1": " > pogoda.txt
echo "Temperatura wynosi $(echo "$dzis" | jq ".main.temp") °C" >> pogoda.txt
echo "Wilgotność wynosi $(echo "$dzis" | jq ".main.humidity")%" >> pogoda.txt
echo "----------------------------------">> pogoda.txt
echo "Pogoda na następne 5 dni:">> pogoda.txt
echo "----------------------------------">> pogoda.txt
#petla ktora wypisuje dane 5 dni prognozy
for ((i=0; i<prognoza_count; i++)); do
    dt=$(echo "$pogoda" | jq -r ".[$i].dt_txt")
    temp=$(echo "$pogoda" | jq ".[$i].main.temp")
    wilg=$(echo "$pogoda" | jq ".[$i].main.humidity")
    echo "Data: $dt">>pogoda.txt
    echo "Temperatura: $temp °C">>pogoda.txt
    echo "Wilgotność: $wilg%">>pogoda.txt
    echo "----------------------------------">>pogoda.txt
done
#zamiana znaków co psuły
sed -i 's/ś/s/g; s/ć/c/g; s/ź/z/g' pogoda.txt
#zamina czcionki ktora lepiej pracuje z znakami i zmiana pliku z txt na pdf
iconv -f UTF-8 -t ISO-8859-2//TRANSLIT pogoda.txt -o pogoda-iso.txt
enscript --font=Courier10 -o - pogoda-iso.txt | ps2pdf - raport.pdf
rm pogoda-iso.txt
#koniec



