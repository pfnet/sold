#! /bin/bash -eu

aarch64-linux-gnu-gcc -fPIC -c -o lib.o lib.c
aarch64-linux-gnu-gcc -Wl,--hash-style=gnu -shared -Wl,-soname,lib.so -o lib.so lib.o
aarch64-linux-gnu-gcc -Wl,--hash-style=gnu -o main main.c -ldl 

mv lib.so lib.so.original
$(git rev-parse --show-toplevel)/build/sold -i lib.so.original -o lib.so.soldout --section-headers --check-output --custom-library-path /usr/aarch64-linux-gnu/lib

# Use sold
ln -sf lib.so.soldout lib.so

# Use original
# ln -sf lib.so.original lib.so

LD_LIBRARY_PATH=. qemu-aarch64 -L /usr/aarch64-linux-gnu ./main
