#include "fuga.h"

int main() {
    catch_exception_fuga();
    try {
        throw_exception_fuga();
    } catch (CustomException& e) {
        std::cout << "Caught CustomException" << std::endl;
    }
}
