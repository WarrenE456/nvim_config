#include <iostream>

class Dog {
    int loudness;
public:
    Dog(int loudness) {
        this->loudness = loudness;
    }
    void bark() {
        std::cout << "Bark this loud: " << this->loudness << "\n";
    }
    ~Dog() {
        std::cout << "The dog barked itself out of scope.\n";
    }
};

int main() {
    auto dog = Dog(999);
    dog.bark();
}
