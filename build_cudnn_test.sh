#! /bin/bash

set -eux -o pipefail

gcc cudnn_test.c /usr/lib/x86_64-linux-gnu/libcudnn.so.9 -I/usr/include
./build/sold -i a.out -o a.out.soldout --delete-unused-DT_STRTAB
