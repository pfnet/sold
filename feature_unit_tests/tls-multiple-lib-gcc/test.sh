#! /bin/bash -eu

gcc -fPIC -c -o base.o base.c
gcc -fPIC -c -o base2.o base2.c
gcc -fPIC -c -o lib.o lib.c
gcc -Wl,--hash-style=gnu -shared -Wl,-soname,base.so -o original/base.so base.o
gcc -Wl,--hash-style=gnu -shared -Wl,-soname,base2.so -o original/base2.so base2.o
gcc -Wl,--hash-style=gnu -shared -Wl,-soname,lib.so -o original/lib.so lib.o original/base2.so original/base.so
gcc -Wl,--hash-style=gnu -shared -Wl,-soname,lib.so -o answer/lib.so lib.o base2.o base.o

# Without sold
# LD_LIBRARY_PATH=original gcc -Wl,--hash-style=gnu -o main.out main.c original/lib.so original/base2.so original/base.so
# LD_LIBRARY_PATH=original ./main.out

LD_LIBRARY_PATH=original $(git rev-parse --show-toplevel)/build/sold original/lib.so -o sold_out/lib.so --section-headers --check-output
 
LD_LIBRARY_PATH=sold_out gcc -Wl,--hash-style=gnu -o main.out main.c sold_out/lib.so
LD_LIBRARY_PATH=sold_out ./main.out
