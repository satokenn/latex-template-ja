#include <iostream>
using namespace std;

int main() {
    int weather;
    cout << "今日の天気を数字で教えてください : " 
    cin >> weather;

    if(weather == 1) {
        cout << "今日は晴れですね\n";
    }
    else if(weather == 2) {
        cout << "今日は曇りですね\n";
    } else {
        cout << "今日は雨ですね\n";
    }
    return 0;
}