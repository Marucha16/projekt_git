#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Użycie: $0 <KLUCZ_API> <MIASTO>"
  exit 1
fi

API_KEY=$1
CITY=$2

RESPONSE=$(curl -s "https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=metric")

if [[ -z "$RESPONSE" ]]; then
  echo "Błąd pobierania danych."
  exit 1
fi

CODE=$(echo "$RESPONSE" | jq -r '.cod')

if [[ "$CODE" != "200" ]]; then
  MESSAGE=$(echo "$RESPONSE" | jq -r '.message')
  echo "Błąd: $MESSAGE"
  exit 1
fi

TEMP=$(echo "$RESPONSE" | jq -r '.main.temp')
DESC=$(echo "$RESPONSE" | jq -r '.weather[0].description')

echo "Pogoda w $CITY:"
echo "Temperatura: ${TEMP}°C"
echo "Opis: $DESC"
