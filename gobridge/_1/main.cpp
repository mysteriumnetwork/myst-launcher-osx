#include <iostream>
#include <string>
#include "bidder_module.h"

int main() {
    int res = Add(1, 2);
    std::cout << res << std::endl;
    
    GoString str;
    str.p = "Hello World";
    str.n = strlen(str.p);
    Print(str);
    
    std::string s = "Bidder";
    char *cstr = new char[s.length()+1];
    std::strcpy (cstr, s.c_str());

    cstr = StrFxn(cstr);
    std::cout << cstr << std::endl;
    delete[] cstr;

    return 0;
}

