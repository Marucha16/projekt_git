# Głwna klasa student
class Student:
    def __init__(self, imie,nazwisko,numer_albumu):
        self.__imie = imie
        self.__nazwisko = nazwisko
        self.__numer_albumu = numer_albumu
        self.__email=self.mail()
    # Funkcje pozyskiwania wiadomosci
    def get_imie(self):
        return self.__imie

    def get_nazwisko(self):
        return self.__nazwisko

    def get_numeralbumu(self):
        return self.__numer_albumu

    def get_email(self):
        return self.__email

    def set_imie(self, imie):
        self.__imie = imie

    def set_nazwisko(self, nazwisko):
        self.__nazwisko = nazwisko

# Tworzenie mail
    def mail(self):
        return self.__numer_albumu + '@gov.student.pl'
    #Trzy klasy pytające o inne zależności
class Inzynier(Student):
    def praktyki(self):
      self.prakt = bool(int(input("Czy były odpyte praktyki, jesli tak wpisz 1, w innym przypadku 0:")))
      print(self.prakt)
class Magister(Student):
    def ocena(self):
        self.ocena1 = float(input("Podaj ocene z egzaminu:"))
        print(self.ocena1)

class Doktorat(Student):
    def prowadzone_zajecia(self):
        self.zaj =[]
        self.x=1
        while self.x!=0:
            self.zaj.append(input("Podaj zajecia:"))
            self.x = int(input("Jesli chcesz zakonczyc dodawanie zajec wpisz 0, w innym wypadku inna liczbe:"))
            print(self.zaj)






# Przykład użycia
inz = Inzynier("Anna", "Kowalska", "202345")
inz.praktyki()
print("E-mail inżyniera:", inz.get_email())

mag = Magister("Jan", "Nowak", "202400")
mag.ocena()
print("E-mail magistra:", mag.get_email())

dok = Doktorat("Ewa", "Wiśniewska", "202899")
dok.prowadzone_zajecia()
print("E-mail doktoranta:", dok.get_email())







