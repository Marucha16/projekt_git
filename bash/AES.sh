#!/bin/bash
# Nazwa: AES.sh
# Opis: Szyfruje plik przy użyciu algorytmu AES-256-CBC za pomocą OpenSSL.
# Autor: Mateusz
# Wymagania: OpenSSL

# Zapytanie uzytkownika o ścieżkę do pliku
read -p "Podaj sciezke do pliku: " plik 

# Nazwa pliku zaszyforwanego
zaszyfrowany="${plik}.aes"
#pobieranie hasła (ukryte przy wpisywaniu)
read -sp "Podaj hasło do szyfrowania: " haslo
# Szyfrowanie pliku
openssl enc -aes-256-cbc -salt -in "$plik" -out "$zaszyfrowany" -pass pass:"$haslo"

# Sprawdzenie czy się powiodło
if [ $? -eq 0 ]; then
  echo "Plik '$plik' został zaszyfrowany jako '$zaszyfrowany'"
else
  echo "Wystąpił błąd podczas szyfrowania."
fi
