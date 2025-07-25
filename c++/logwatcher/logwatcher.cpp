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
        cerr << "Nie można otworzyć pliku: " << path << endl;
        return 1;
    }
        string line;
    while (getline(file, line)) {
        cout << line << endl;
    }

    while (true) {
        if (getline(file, line)) {
            cout << line << endl;
        } 
        else {
            this_thread::sleep_for(chrono::seconds(1));
            file.clear(); 
        }
    }

}