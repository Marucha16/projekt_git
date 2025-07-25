cmake_minimum_required(VERSION 3.10)

# Nazwa projektu
project(logwatcher)

# Ustaw standard C++
set(CMAKE_CXX_STANDARD 17)

# Dodaj plik źródłowy
add_executable(logwatcher logwatcher.cpp)