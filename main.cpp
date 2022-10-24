#include <iostream>
#include "cpp_test.hpp"

extern "C" {
#include "c_test.h"
}

using namespace std;

int main()
{
    cout << "i am main.cpp hello world" << endl;
    printf_func();

    Base b;
    b.cpp_func();

// make lf_type=3
 #if (3 == D_LF_DEV_TYPE)
    cout << "test ---111 " << endl;
 #endif

    return 0;
}