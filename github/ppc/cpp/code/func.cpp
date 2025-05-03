#include <iostream>
using namespace std;

int Func_Plus(int n, int m);

int main() {
    int a, b, c;
    cin >> a >> b;
    c = Func_Plus(a, b);
    cout << c << endl;
    }

int Func_Plus(int n, int m) {
    int ans;
    ans = n + m;
    return ans;
}