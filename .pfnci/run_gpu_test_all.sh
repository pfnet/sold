#!/bin/bash
set -eux

for LIBTORCH in cu113/1.12.1 cu117/1.13.0; do
    IFS=/ read -r LIBTORCH_ARCH LIBTORCH_VERSION <<< $LIBTORCH
    LIBTORCH_VERSION=$LIBTORCH_VERSION \
    LIBTORCH_ARCH=$LIBTORCH_ARCH \
    bash .pfnci/run_gpu_test.sh
done
