# OpenVINO

## 一.GPU 在linux系统上的配置(Ubuntu 22.04.x LTS) 

此步骤参考https://docs.openvino.ai/2023.3/openvino_docs_install_guides_configurations_for_intel_gpu.html

可以直接运行当前目录下的脚本文件，根据自己系统型号选择不同的脚本

[gpu22.04.x.sh](gpu22.04.x.sh) 

1. 更新源并且安装wget

```shell
sudo apt update
sudo apt install -y gpg-agent wget
```

2.使用 `wget` 下载了特定版本的 Intel GPU 驱动程序安装文件

```
. /etc/os-release
if [[ ! " jammy " =~ " ${VERSION_CODENAME} " ]]; then
  echo "Ubuntu version ${VERSION_CODENAME} not supported"
else
  wget https://repositories.intel.com/gpu/ubuntu/dists/jammy/lts/2350/intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run
  chmod +x intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run
  sudo ./intel-gpu-ubuntu-${VERSION_CODENAME}-2350.run
fi
```

3.安装的驱动文件和库

```shell
 apt-get install -y ocl-icd-libopencl1 intel-opencl-icd intel-level-zero-gpu level-zero
```

## 二.GPU在linux系统上配置(Ubuntu 20.04.x LTS ）

可以直接运行当前目录下的脚本文件，根据自己系统型号选择不同的脚本

 [gpu20.04.x.sh](gpu20.04.x.sh) (如果执行失败，自己手动输入一下3.)

1.更新源和安装一些第2步需要的工具

```shell
sudo apt-get update
sudo apt-get install -y --no-install-recommends curl gpg gpg-agent 
```

2.下载 Intel GPU 软件仓库的 GPG 密钥，并将其解码，将 Intel GPU 软件仓库的源添加到系统中。

```
sudo curl https://repositories.intel.com/graphics/intel-graphics.key | gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/graphics/ubuntu focal-legacy main' | tee  /etc/apt/sources.list.d/intel.gpu.focal.list 
```

3.安装的驱动文件和库

```shell
apt-get update
apt-get update && apt-get install -y --no-install-recommends intel-opencl-icd intel-level-zero-gpu level-zero
```



## 三.CMAKE 配置

```cmake
cmake_minimum_required(VERSION 3.17)
project(openvino)
file(GLOB_RECURSE sources CONFIGURE_DEPENDS src/*.cpp)

find_package(OpenVINO REQUIRED)

add_executable(${PROJECT_NAME}  ${sources})

target_link_libraries(${PROJECT_NAME} openvino::runtime)
                                    
                          
```

## 四.示例代码(用于查看GPU是否配置成功)

```
#include <iostream>

#include <openvino/openvino.hpp>

int main() {
    // 初始化Inference Engine
    ov::Core ie;
    //获取可用设备
    auto devices = ie.get_available_devices();
    for (auto& device : devices) {
        std::cout << device << "  ";
    }
    std::cout << std::endl;
    return 0;
}
```

