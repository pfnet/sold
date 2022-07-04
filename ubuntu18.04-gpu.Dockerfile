ARG IMAGE_NAME
FROM ${IMAGE_NAME}

# See https://github.com/NVIDIA/nvidia-docker/issues/1631
RUN rm -f /etc/apt/sources.list.d/cuda.list && \
    rm -f /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-key del 7fa2af80
RUN apt-get update
RUN apt-get install -y ninja-build cmake gcc g++ git python3 python3-distutils python3-dev python3-pip g++-aarch64-linux-gnu qemu qemu-system-aarch64 qemu-user rsync software-properties-common wget

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb
RUN dpkg -i cuda-keyring_1.0-1_all.deb
RUN add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
RUN apt-get update
RUN apt-get install -y libcudnn8-dev

ARG TORCH_VERSION
ENV TORCH_VERSION=${TORCH_VERSION}
RUN pip3 install pytest numpy torch==${TORCH_VERSION} -f https://download.pytorch.org/whl/torch_stable.html

COPY . /sold
WORKDIR /sold
RUN rm -rf build
RUN mkdir build && cd build && cmake -DTorch_DIR=$(python3 -c "import site; print (site.getsitepackages()[0])")/torch/share/cmake/Torch -GNinja -DSOLD_PYBIND_TEST=ON -DSOLD_LIBTORCH_TEST=ON ..
RUN cmake --build build
RUN cd build && ctest
