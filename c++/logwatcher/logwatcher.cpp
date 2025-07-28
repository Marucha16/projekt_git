/*
 * Nazwa: Log Watcher
 * Opis: Program monitoruje podany plik tekstowy(np z logami) i wypisuje na ekran jego zawartość.
 *       Najpierw wyświetla wszystkie istniejące linie, a następnie na bieżąco
 *       obserwuje plik i wypisuje nowe linie, które się pojawią.
 * Autor: Mateusz
*/
#include <iostream>
#include <fstream>
#include <string>
#include <thread>
#include <chrono>

using namespace std;

int main() {
    string path;
    cout<< "Give path to the file which you want to observate: ";
    getline(cin, path);
    ifstream file(path);
    if (!file.is_open()) {
        cerr << "You can't open file: " << path << endl;
        return 1;
    }
    cout << "--------------------------------------------------------" << endl;
    cout << "!!! Start observating logs, to end click ctrl + c !!!" << endl; // ctrl + c tylko w terminalu
    cout << "--------------------------------------------------------" << endl;
    string line;
    // Wypisanie isteniejącyh liń w pliku
    while (getline(file, line)) {
        cout << line << endl;
    }
    // Czekanie na pojawienie się nowych
    while (true) {
        if (getline(file, line)) {
            cout << line << endl;
        } 
        else {
            this_thread::sleep_for(chrono::seconds(1));
            file.clear(); // czyścimy flagi eof, aby móc dalej czytać, inaczej program zamarznie
        }
    }
}