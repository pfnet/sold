#! /bin/bash -eu

aarch64-linux-gnu-gcc -fPIC -c -o libmax1.o libmax1.c
aarch64-linux-gnu-gcc -Wl,--hash-style=gnu -shared -Wl,-soname,libmax.so -o libmax.so.1 libmax1.o
ln -sf libmax.so.1 libmax.so
aarch64-linux-gnu-gcc -Wl,--hash-style=gnu -o vertest1 vertest1.c libmax.so

aarch64-linux-gnu-gcc -fPIC -c -o libmax2.o libmax2.c
aarch64-linux-gnu-gcc -Wl,--hash-style=gnu -shared -Wl,-soname,libmax.so -Wl,--version-script,libmax2.def -o libmax.so.2 libmax2.o
ln -sf libmax.so.2 libmax.so
aarch64-linux-gnu-gcc -Wl,--hash-style=gnu -o vertest2 vertest2.c libmax.so

LD_LIBRARY_PATH=. $(git rev-parse --show-toplevel)/build/sold -e libmax.so -o vertest1.out vertest1 --section-headers --check-output  --custom-library-path /usr/aarch64-linux-gnu/lib
LD_LIBRARY_PATH=. qemu-aarch64 -L /usr/aarch64-linux-gnu ./vertest1.out
LD_LIBRARY_PATH=. $(git rev-parse --show-toplevel)/build/sold -e libmax.so -o vertest2.out vertest2  --section-headers --check-output --custom-library-path /usr/aarch64-linux-gnu/lib
LD_LIBRARY_PATH=. qemu-aarch64 -L /usr/aarch64-linux-gnu ./vertest2.out
