#!/bin/bash
# Nazwa: wyszukiwanie_lokalizacji.sh
# Opis: Odczytuje współrzędne GPS z metadanych pliku (np. zdjęcia) i wyświetla je w konsoli.
# Wymaga: exiftool
# Autor: Mateusz

# Sprawdzanie liczby argumentów
if [[ $# -ne 1 ]]; then
    echo "Podales wieciej akrgumentow niz jeden."
    exit 1
fi

PLIK="$1"

# Sprawdzenie czy plik istnieje
if [[ ! -f "$PLIK" ]]; then
    echo "Podany plik nie istnieje"
    exit 1
fi

# Pobieranie współrzędnych GPS z metadanych (dokładna wartość liczbowo)
la=$(exiftool -n -GPSLatitude "$PLIK" | awk -F': ' '{print $2}')
lo=$(exiftool -n -GPSLongitude "$PLIK" | awk -F': ' '{print $2}')

# Sprawdzenie czy dane GPS są obecne
if [[ -z "$la" || -z "$lo" ]]; then
    echo "Brak danych GPS w pliku $PLIK"
else
    echo "Pozycja GPS: latitude = $la, longitude = $lo"
fi

