#include <iostream>
#include <cstring>
using namespace std;

struct s_type {
    int i;
    char str[80];
}s, *p;

int main() {
    p = &s;
    s.i = 10;
    p -> i = 10;
    strcpy(p -> str, "私は構造体が好きです.");

    cout << s.i << " " <<  p -> i  << " " << p -> str << endl;
    return 0;
}    
