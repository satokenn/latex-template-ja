#include <iostream>
using namespace std;

int main() {
    int a[3] = {1, 1, 1};
    int *p;
    p = a;
    cout << *p << *(p + 1) << *(p + 2) << endl;
    cout << a[0] << a[1] << a[2] << endl;
    return 0;
}