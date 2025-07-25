#!/bin/bash
# Nazwa: Virus_total.sh
# Opis: Wysyła plik przez api do Virus total i sprawdza czy jest bezpieczny
# Autor: Mateusz
# Wymagania: jq

# Z1 Obliczenie sumy (SHA256)
check() {
    checksum=$(sha256sum "$1" | awk '{print $1}')
    echo "To suma Sha 256 $checksum"
}

# Z2 reputacja sprawdzanie
reputacja() {
    #wyslanie pliku
    api="11f3bbbdf47a666b0d060c04d8f56108b60ebfd2e9baf19e4b0a65e163e14ebc"
    wyslanie=$(curl -s --request POST \
        --url "https://www.virustotal.com/api/v3/files" \
        --header "x-apikey: $api" \
        --form "file=@$1")
    echo "Odpowiedź z przesłania pliku:"
    echo "$wyslanie" | jq .
    # Sprawdzenie czy plik został poprawnie przesłany
    analiza=$(echo "$wyslanie" | jq -r '.data.id')
    if [ -z "$analiza" ] || [ "$analiza" == "null" ]; then
        echo "Błąd: Nie udało się uzyskać ID analizy!"
        exit 1
    fi

    #oczekiwanie na analize
    while true; do
        odp=$(curl -s --request GET \
            --url "https://www.virustotal.com/api/v3/analyses/$analiza" \
            --header "x-apikey: $api")

        status=$(echo "$odp" | jq -r '.data.attributes.status')
        echo "Status analizy: $status"

        if [ "$status" == "completed" ]; then
            break
        fi

        echo "Oczekiwanie na zakończenie analizy..."
        sleep 5
    done
    # Interpretacja wyników analizy 
    data=$(echo "$odp" | jq -r '.data.attributes.date')
    liczbaz=$(echo "$odp" | jq '.data.attributes.stats.malicious')
    liczbas=$(echo "$odp" | jq '.data.attributes.stats | add')
    echo "Data ostatniej analizy: $(date -d @$data)"
    echo "Plik został przetestowany przez $liczbas silników."
    echo "Liczba wykrytych zagrożeń: $liczbaz" 
    if [ "$liczbaz" -eq 0 ]; then
        echo "Plik jest bezpieczny!"
    else
        echo "Plik zawiera zagrożenia!"
    fi
}
 
# Funkcja główna
main() {
    read -p "Podaj plik, który chcesz sprawdzić: " plik
    # Sprawdzenie czy plik istnieje
    if [ ! -f "$plik" ]; then
        echo "Plik $plik nie istnieje!"
        exit 1
    fi
    check "$plik"
    reputacja "$plik"
}
 
main


