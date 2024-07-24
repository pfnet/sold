#! /bin/bash -eu

g++ -fPIC -shared -o libfuga.so -Wl,-soname,libfuga.so fuga.cc 
g++ main.cc -o main.out libfuga.so
LD_LIBRARY_PATH=. $(git rev-parse --show-toplevel)/build/sold -i libfuga.so.original -o libfuga.so.soldout --section-headers --check-output

cp libfuga.so libfuga.so.original
# Use sold
ln -sf libhoge.so.soldout libhoge.so
# Use original
# ln -sf libhoge.so.original libhoge.so
ln -sf libfuga.so.soldout libfuga.so

LD_LIBRARY_PATH=. ./main.out
