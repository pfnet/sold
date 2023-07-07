#!/bin/bash
set -eux

LIBTORCH_VERSION=${LIBTORCH_VERSION:-1.13.0}
LIBTORCH_ARCH=${LIBTORCH_ARCH:-cu117}
OS=${OS:-ubuntu22.04}

cat >> test.sh <<'EOF'
#!/bin/bash
set -eux

nvidia-smi

export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    cmake \
    clang-format \
    rsync \
    git \
    ninja-build \
    g++-aarch64-linux-gnu \
    qemu \
    qemu-system-aarch64 \
    qemu-user \
    wget \
    unzip

pip3 install pytest numpy cmake-format
./run-format.sh
./download-libtorch.sh
LIBTORCH_DIR=$(pwd)/pytorch-install/libtorch

mkdir build && cd build && \
    cmake .. \
        -GNinja \
        -DSOLD_PYBIND_TEST=ON \
        -DSOLD_LIBTORCH_TEST=ON \
        -DCMAKE_PREFIX_PATH=${LIBTORCH_DIR}/share/cmake/Torch/
ninja

ctest --output-on-failure
EOF

docker run --gpus=all --rm \
    -v $(pwd):/sold \
    -w /sold \
    -e LIBTORCH_VERSION=${LIBTORCH_VERSION} \
    -e LIBTORCH_ARCH=${LIBTORCH_ARCH} \
    nvidia/cuda:11.7.1-cudnn8-devel-${OS} \
    /bin/bash /sold/test.sh
