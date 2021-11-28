#! /bin/bash -eu

aarch64-linux-gnu-g++ -fPIC -shared -o libfuga.so -Wl,-soname,libfuga.so fuga.cc 
aarch64-linux-gnu-g++ -fPIC -shared -o libhoge.so.original -Wl,-soname,libhoge.so hoge.cc libfuga.so
aarch64-linux-gnu-g++ main.cc -o main libhoge.so.original libfuga.so
LD_LIBRARY_PATH=. $(git rev-parse --show-toplevel)/build/sold -i libhoge.so.original -o libhoge.so.soldout --section-headers --check-output --custom-library-path /usr/aarch64-linux-gnu/lib

# Use sold
ln -sf libhoge.so.soldout libhoge.so
# Use original
# ln -sf libhoge.so.original libhoge.so

LD_LIBRARY_PATH=. qemu-aarch64 -L /usr/aarch64-linux-gnu ./main
