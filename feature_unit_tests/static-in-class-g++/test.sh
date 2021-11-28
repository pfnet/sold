#! /bin/bash -eu

g++ -fPIC -c -o lib.o lib.cc
g++ -shared -Wl,-soname,lib.so -o lib.so lib.o
g++ -Wl,--hash-style=gnu -o main.out main.cc lib.so

mv lib.so lib.so.original
$(git rev-parse --show-toplevel)/build/sold -i lib.so.original -o lib.so.soldout --section-headers --check-output

# Use sold
ln -sf lib.so.soldout lib.so

# Use original
# ln -sf lib.so.original lib.so

LD_LIBRARY_PATH=. ./main.out
