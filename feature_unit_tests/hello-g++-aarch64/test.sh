#! /bin/bash

aarch64-linux-gnu-g++ hello.cc -o hello
$(git rev-parse --show-toplevel)/build/sold hello -o hello.out --section-headers --check-output --custom-library-path /usr/aarch64-linux-gnu/lib
qemu-aarch64 -L /usr/aarch64-linux-gnu ./hello.out
