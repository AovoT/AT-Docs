#!/bin/bash

# 更新软件包列表
sudo apt-get update

# 安装必要软件包
sudo apt-get install -y --no-install-recommends curl gpg gpg-agent 

# 下载并安装 Intel Graphics 存储库密钥
sudo curl https://repositories.intel.com/graphics/intel-graphics.key | gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/graphics/ubuntu focal-legacy main' | sudo tee /etc/apt/sources.list.d/intel.gpu.focal.list 

# 更新软件包列表
sudo apt-get update

# 安装 Intel OpenCL 和 Level Zero GPU 软件包
sudo apt-get install -y --no-install-recommends intel-opencl-icd intel-level-zero-gpu level-zero 

echo "安装完成"

