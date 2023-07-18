#!/bin/bash -eux

cd "$(git rev-parse --show-toplevel)" 
cmake -DCMAKE_PREFIX_PATH=$(realpath ~/tmp/pytorch-install/share/cmake/Torch) -DSOLD_LIBTORCH_TEST=ON -DSOLD_PYBIND_TEST=ON -GNinja -B build -S . -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-11.7 -DCMAKE_CUDA_COMPILER=/usr/local/cuda-11.7/bin/nvcc
