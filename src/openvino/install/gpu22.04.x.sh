#!/bin/bash

# 导入系统版本信息
. /etc/os-release

# 检查当前 Ubuntu 版本是否为 "jammy"
if [[ ! " jammy " =~ " ${VERSION_CODENAME} " ]]; then
  echo "Ubuntu version ${VERSION_CODENAME} not supported"
  exit 1
fi

# 下载 Intel GPU 驱动程序安装文件
echo "Downloading Intel GPU driver for Ubuntu ${VERSION_CODENAME}..."
wget https://repositories.intel.com/gpu/ubuntu/dists/jammy/lts/2350/intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run

# 检查下载是否成功
if [ $? -ne 0 ]; then
  echo "Failed to download Intel GPU driver"
  exit 1
fi

# 添加执行权限
chmod +x intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run

# 运行安装程序
echo "Installing Intel GPU driver..."
sudo ./intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run

# 检查安装是否成功
if [ $? -ne 0 ]; then
  echo "Failed to install Intel GPU driver"
  exit 1
fi

echo "Intel GPU driver installed successfully"
exit 0

