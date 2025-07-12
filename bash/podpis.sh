#!/bin/bash
read -p "Podaj sciezke do pliku" plik
podpis="${plik}.sig"

# Tworzenie podpisu cyfrowego
gpg --output "$podpis" --detach-sign "$plik"

# Sprawdzenie, czy podpis się udał
if [ $? -eq 0 ]; then
  echo "Plik '$plik' został podpisany jako '$podpis'"
else
  echo "Wystąpił błąd podczas podpisywania pliku."
fi
