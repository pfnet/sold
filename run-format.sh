#! /bin/bash -eu

cd "$(git rev-parse --show-toplevel)"
git ls-files -- '**/*.h' '**/*.cc' '**/*.c'| grep -v "libtorch_test/cuBLAS_test" | grep -v "libtorch_test/cuBLASLt_test" | xargs -P4 clang-format -i
git ls-files -- '**/CMakeLists.txt' | grep -v "libtorch_test/cuBLAS_test" | grep -v "libtorch_test/cuBLASLt_test" | xargs -P4 cmake-format -i
git diff --exit-code -- .
