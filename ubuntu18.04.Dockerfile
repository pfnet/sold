ARG IMAGE_NAME
FROM ${IMAGE_NAME}

RUN apt-get update
RUN apt-get install -y ninja-build cmake gcc g++ git python3 python3-distutils python3-dev python3-pip g++-aarch64-linux-gnu qemu qemu-system-aarch64 qemu-user rsync software-properties-common wget

ARG TORCH_VERSION
ENV TORCH_VERSION=${TORCH_VERSION}
RUN pip3 install pytest numpy torch==${TORCH_VERSION} -f https://download.pytorch.org/whl/torch_stable.html

COPY . /sold
WORKDIR /sold
RUN rm -rf build
RUN mkdir build && cd build && cmake -DTorch_DIR=$(python3 -c "import site; print (site.getsitepackages()[0])")/torch/share/cmake/Torch -GNinja -DSOLD_PYBIND_TEST=ON -DSOLD_LIBTORCH_TEST=ON ..
RUN cmake --build build
RUN cd build && ctest
