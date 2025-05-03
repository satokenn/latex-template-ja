#include <iostream>
using namespace std;

struct Student {
    string name;
    int age;
    int id;
} Student1;

int main() {
    cin >> Student1.name >> Student1.age >> Student1.id;
    cout << "以下の人物を登録しました.\n" << "名前 : " << Student1.name << endl << "年齢 : " << Student1.age << endl << "学籍番号 : " << Student1.id << endl;
}
