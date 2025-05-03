#include <iostream>
using namespace std;

void recursion(int i);
int main() {
    recursion(5);
    return 0;
}

void recursion (int i) {
    if(i == 0) return;
    cout << i << endl;
    recursion(i - 1);
    return 0;
}
