#!/bin/bash
read -p "Podaj sciezke do pliku: " plik 
zaszyfrowany="${plik}.aes"
read -sp "Podaj hasło do szyfrowania: " haslo
openssl enc -aes-256-cbc -salt -in "$plik" -out "$zaszyfrowany" -pass pass:"$haslo"
if [ $? -eq 0 ]; then
  echo "Plik '$plik' został zaszyfrowany jako '$zaszyfrowany'"
else
  echo "Wystąpił błąd podczas szyfrowania."
fi
