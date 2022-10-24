#include "cpp_test.hpp"
#include <iostream>

using namespace std;

Base :: Base()
{
    cout << "Base :: Base()" << endl;
}

Base :: ~Base()
{
    cout << "Base :: ~Base()" << endl;
}

void Base :: cpp_func()
{
    cout << "i am cpp_test hello world" << endl;
}