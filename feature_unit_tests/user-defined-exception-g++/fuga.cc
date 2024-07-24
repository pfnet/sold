#include "fuga.h"

struct CustomException {};

void throw_exception_fuga() {
    throw CustomException();
}

void catch_exception_fuga() {
    try {
        throw_exception_fuga();
    } catch (CustomException) {
        std::cerr << "Caught CustomException" << std::endl;
    }
}
