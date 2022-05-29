#! /bin/bash -eux

# ========== ubuntu18.04 start ==========
# ---------- CPU start ----------
sudo docker build -f ubuntu18.04.Dockerfile --build-arg TORCH_VERSION=1.8.0+cpu IMAGE_NAME=ubuntu:18.04 .
sudo docker build -f ubuntu18.04.Dockerfile --build-arg TORCH_VERSION=1.8.1+cpu IMAGE_NAME=ubuntu:18.04 .
sudo docker build -f ubuntu18.04.Dockerfile --build-arg TORCH_VERSION=1.9.0+cpu IMAGE_NAME=ubuntu:18.04 .
sudo docker build -f ubuntu18.04.Dockerfile --build-arg TORCH_VERSION=1.9.1+cpu IMAGE_NAME=ubuntu:18.04 .
sudo docker build -f ubuntu18.04.Dockerfile --build-arg TORCH_VERSION=1.10.0+cpu IMAGE_NAME=ubuntu:18.04 .
sudo docker build -f ubuntu18.04.Dockerfile --build-arg TORCH_VERSION=1.10.1+cpu IMAGE_NAME=ubuntu:18.04 .
sudo docker build -f ubuntu18.04.Dockerfile --build-arg TORCH_VERSION=1.10.2+cpu IMAGE_NAME=ubuntu:18.04 .
# ---------- CPU end ----------

# ---------- GPU start ----------
# DT_INIT and DT_FINI.
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.8.0+cu101 --build-arg IMAGE_NAME=nvidia/cuda:10.1-devel-ubuntu18.04 .
# F0530 00:17:28.955174   231 sold.cc:135] Check failed: file_offset < offsets_[main_binary_.get()]
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.8.0+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .

sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.8.1+cu101 --build-arg IMAGE_NAME=nvidia/cuda:10.1-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.8.1+cu102 --build-arg IMAGE_NAME=nvidia/cuda:10.2-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.8.1+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .

sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.9.0+cu102 --build-arg IMAGE_NAME=nvidia/cuda:10.2-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.9.0+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .

sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.9.0+cu102 --build-arg IMAGE_NAME=nvidia/cuda:10.2-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.9.0+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .

sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.9.1+cu102 --build-arg IMAGE_NAME=nvidia/cuda:10.2-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.9.1+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .

sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.0+cu102 --build-arg IMAGE_NAME=nvidia/cuda:10.2-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.0+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.0+cu113 --build-arg IMAGE_NAME=nvidia/cuda:11.3-devel-ubuntu18.04 .

sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.1+cu102 --build-arg IMAGE_NAME=nvidia/cuda:10.2-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.1+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.1+cu113 --build-arg IMAGE_NAME=nvidia/cuda:11.3-devel-ubuntu18.04 .

sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.2+cu102 --build-arg IMAGE_NAME=nvidia/cuda:10.2-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.2+cu111 --build-arg IMAGE_NAME=nvidia/cuda:11.1-devel-ubuntu18.04 .
sudo docker build -f ubuntu18.04-gpu.Dockerfile --build-arg TORCH_VERSION=1.10.2+cu113 --build-arg IMAGE_NAME=nvidia/cuda:11.3-devel-ubuntu18.04 .
# ---------- GPU end ----------
# ========== ubuntu18.04 end ==========

sudo docker build -f ubuntu20.04.Dockerfile .
sudo docker build -f ubuntu22.04.Dockerfile .
sudo docker build -f fedora-latest.Dockerfile .
