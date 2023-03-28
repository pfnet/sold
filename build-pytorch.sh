#! /bin/bash -eux

# git clone --branch v1.13.0 git@github.com:pytorch/pytorch.git pytorch
# pushd pytorch
# git submodule update --init --recursive
# popd

BUILD_DIR=$(pwd)/pytorch-build
INSTALL_DIR=$(pwd)/pytorch-install
mkdir -p ${BUILD_DIR}
mkdir -p ${INSTALL_DIR}
cmake -S pytorch -B ${BUILD_DIR} -G Ninja \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo \
    -DPYTHON_EXECUTABLE:PATH=`which python3` \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -DUSE_CUDA=OFF \
    -DUSE_CUDNN=OFF \
    -DUSE_ROCM=OFF \
    -DUSE_NCCL=OFF \
    -DUSE_NNPACK=OFF \
    -DCMAKE_CXX_COMPILER_LAUNCHER=sccache \
    -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR}
cmake --build pytorch-build -- -j12 install
