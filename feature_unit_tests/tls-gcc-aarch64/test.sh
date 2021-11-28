#! /bin/bash -eu

aarch64-linux-gnu-gcc -Wl,--hash-style=gnu -o main main.c

$(git rev-parse --show-toplevel)/build/sold main -o main.out --section-headers --custom-library-path /usr/aarch64-linux-gnu/lib
qemu-aarch64 -L /usr/aarch64-linux-gnu ./main.out
