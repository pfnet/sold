#! /bin/bash -ex

LIBTORCH_ARCH=${LIBTORCH_ARCH:-"cu117"}
LIBTORCH_ABI="-cxx11-abi"
LIBTORCH_LIBOPT="-shared-with-deps"
LIBTORCH_VERSION=${LIBTORCH_VERSION:-"1.13.0"}
LIBTORCH_ZIP_SUFFIX="%2B${LIBTORCH_ARCH}"

URL="https://download.pytorch.org/libtorch${LIBTORCH_RELEASE_TYPE}/${LIBTORCH_ARCH}/libtorch${LIBTORCH_ABI}${LIBTORCH_OSNAME}${LIBTORCH_LIBOPT}-${LIBTORCH_VERSION}${LIBTORCH_ZIP_SUFFIX}.zip"

wget -q -O libtorch.zip "${URL}"
unzip -q libtorch.zip -d pytorch-install
