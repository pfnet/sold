#! /bin/bash -eu

g++ -fPIC -c -o lib.o lib.cc
g++ -Wl,--hash-style=gnu -shared -Wl,-soname,lib.so -o lib.so lib.o
g++ -Wl,--hash-style=gnu -o main main.cc lib.so

mv lib.so lib.so.original
$(git rev-parse --show-toplevel)/build/sold -i lib.so.original -o lib.so.soldout --section-headers --check-output

# Use sold
ln -sf lib.so.soldout lib.so
echo ----------- Use sold -----------
LD_LIBRARY_PATH=. ./main

# Use original
ln -sf lib.so.original lib.so
echo ----------- Use original -----------
LD_LIBRARY_PATH=. ./main
