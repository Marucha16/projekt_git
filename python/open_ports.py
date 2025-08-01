"""
Nazwa:
- open_ports.py

Opis:
- Prosty skaner portów TCP w Pythonie.
Sprawdza, które porty są otwarte na wskazanym adresie IP w zadanym zakresie.

Wymagania:
- Komputer

Autor: 
- Mateusz
"""

import socket
def skan_portow(ip, start_port, end_port):
    print(f"Skanowanie hosta {ip} od portu {start_port} do {end_port}")
    porty = []
# Sprawdza porty po kolei
    for port in range(start_port, end_port + 1):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(0.5) # Czas na probe połączenia
            odp = sock.connect_ex((ip, port)) 
            if odp == 0:
                print(f"Otwarty port: {port}")
                porty.append(port)
    if not porty:
        print("Nie znaleziono otwartych portów.")
# Wywołanie
skan_portow("192.168.1.197",1,21)
