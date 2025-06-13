import socket
def skan_portow(ip, start_port, end_port):
    print(f"Skanowanie hosta {ip} od portu {start_port} do {end_port}")
    porty = []
    for port in range(start_port, end_port + 1):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(0.5)
            odp = sock.connect_ex((ip, port))
            if odp == 0:
                print(f"Otwarty port: {port}")
                porty.append(port)
    if not porty:
        print("Nie znaleziono otwartych portów.")
skan_portow("192.168.1.197",1,21)