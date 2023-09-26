# -1. TODO:

Realsense 联合编译

双系统安全引导, BIOS配置

# 一. 主要流程概述

-> 搜狗拼音 -> 双系统时间同步 -> typora -> 星火(非必要, 但推荐)

-> N卡 ->  cuda -> cuDNN 

-> Qt、OpenCV依赖包 -> Qt -> OpenCV -> Realsense库

-> 日志库spdlog、队内库(kdrobotcpplib(依赖于spdlog)

-> yolov3() 

-> TensorRT(intel) 

-> Anaconda(python的包管理系统) -> (另附)关于Python环境的搭建

-> Pytorch(依赖anaconda)

 -> TensorFlow(依赖anaconda) 

-> IDE -> FSearch

搜狗拼音: https://pinyin.sogou.com/linux/?r=pinyin 

视觉环境配置参考CSDN网址: 
https://blog.csdn.net/qq_25014669/article/details/104651894?spm=1001.2014.3001.5501

https://blog.csdn.net/kunhe0512/article/details/125061911

https://blog.csdn.net/weixin_60864335/article/details/126671341

---

简单介绍

1. CUDA（Compute Unified Device Architecture）是一种由NVIDIA推出的并行计算平台和编程模型。它允许开发者使用标准的C/C++语言编写并行计算程序，并利用GPU的并行计算能力来加速计算任务。CUDA 提供了一套API和工具，使得开发者可以利用GPU的大规模并行计算单元进行高性能计算，包括深度学习的训练和推理。
2. cuDNN（CUDA Deep Neural Network library）是NVIDIA开发的深度神经网络库，用于加速深度学习模型的训练和推理。cuDNN 提供了高度优化的算法和函数，针对深度神经网络的常见操作（如卷积、池化、归一化等）进行加速。它利用了CUDA的并行计算能力和专门优化的算法，使得深度学习模型的运行更加高效和快速。
3. TensorRT（Tensor Runtime）是英伟达（NVIDIA）开发的一个高性能推理引擎，用于在深度学习模型的推理阶段加速。它可以针对特定的硬件进行优化，提供高度并行化的计算能力，并利用深度学习模型的特性来提高推理性能。TensorRT 可以将训练好的模型进行优化和部署，提供低延迟和高吞吐量的推理性能。
4. PyTorch是由Facebook开发和维护的深度学习框架，它以易用性和动态计算图的特点而闻名。具有:
   1. 动态计算图：PyTorch使用动态计算图，这意味着你可以在编写模型时进行动态的计算图构建和调试，方便灵活地进行模型开发和调整。
   2. 简单易用：PyTorch的API设计简洁直观，易于上手，同时与Python语言紧密结合，提供了丰富的工具和库来简化深度学习任务。
   3. 强大的GPU加速：PyTorch支持GPU加速，可以利用GPU的并行计算能力来加速深度学习模型的训练和推理。
5. TensorFlow 是一个开源的深度学习框架，由Google开发。它提供了丰富的工具和库，用于构建和训练各种类型的机器学习模型，包括神经网络。TensorFlow 具有可扩展性和灵活性，可以在各种硬件平台上进行高效的计算。它支持分布式计算、图计算优化和自动微分等功能，使得深度学习模型的开发和部署变得更加简单和高效。
   1. TensorFlow 是一个静态图框架，它允许用户在编写模型之前定义整个计算图，从而使得模型训练的速度更快。
   2. TensorFlow 的 API 设计更加模块化，支持多种语言（如 Python、C++、Java、Go），所以更适合团队合作和开发规模较大的项目。
   3. TensorFlow 的社区非常庞大，拥有许多工具和扩展库，这些工具和扩展库可以帮助用户快速开发复杂的深度学习模型。
   4. 强大的GPU加速：支持GPU加速，可以利用GPU的并行计算能力来加速深度学习模型的训练和推理。

# 二. 搜狗安装

官网：https://pinyin.sogou.com/linux?r=pinyin

官方教程: https://shurufa.sogou.com/linux/guide

下载x86_64     ubuntu22.04系统也适用

~~***在?为什么给了网址还要抄一遍???***~~

```sh
sudo apt update #更新源
sudo apt 
sudo apt install fcitx
# 语言支持->选择fcitx
sudo cp /usr/share/applications/fcitx.desktop /etc/xdg/autostart/  # 开机自启动
sudo apt purge ibus  # 卸载ibus框架
sudo dpkg -i 安装包名  # 安装
# 安装依赖
sudo apt install libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2
sudo apt install libgsettings-qt1
# 重启电脑
reboot
```

# 三. 双系统时间同步问题

```sh
sudo apt install ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc
```

# 四.Typora安装

```sh
# install rar unrar
sudo apt install rar unrar
# unrar
mkdir typora
unrar e typora1.2.4_Linux.rar -d typora
# install
sudo dpkg -i typora_1.2.4_amd64.deb
# replace asar
sudo cp typora/app.asar /usr/share/typora/resources
```

# 五.星火应用商店安装

官网: https://www.spark-app.store/

视频教程(bilibili)：https://www.bilibili.com/video/BV1WL4y1P7LS/?spm_id_from=333.880.my_history.page.click&vd_source=d9f539810e996eac76f619a3a7c9019 up的其他视频也可以看看

在星火安装QQ和微信以及其他软件时可以和windows平台一样便捷,主要用来安装QQ和微信等(方便文件传输),但不要依赖,学会命令行操作是基本技能

---

---

# 零. 必要依赖

```shell
sudo apt install -y \
                    git \
                    vim \
                    cmake \
                    cmake-gui \
                    g++ \
                    gcc
```

***注意：视觉环境各个组件之间的版本要求极为严苛,一定要按照官方版本要求来***

# 一. N卡驱动

CSDN: https://blog.csdn.net/qq_25014669/article/details/104651894?spm=1001.2014.3001.5501

N卡驱动有多种方法

0. 都需要 配置禁用列表(网上给出的禁用列表也不尽相同)

1. apt 安装. 就像上面文章一样查找合适驱动, 用apt去安装

2. 下载官方驱动. 选择合适的驱动下载. 这里给出网址

   官网: https://www.nvidia.cn/
   
   Download: https://www.nvidia.cn/Download/index.aspx?lang=cn

3. 切换到虚拟终端中执行1. 2. (具体还需要其他操作, 请自行查找)

4. 利用图形界面安装(一般不好使)
   左下角(~~九筒~~) -> 软件与更新(software and update) -> 附加驱动去下载

---

---

以下只写最稳定靠谱的方式,即使用官方的NVIDIA驱动进行手动安装

## 1.禁用nouveau(nouveau是通用的驱动程序)

```shell
sudo vim /etc/modprobe.d/blacklist.conf
```

在打开的blacklist.conf末尾添加如下，保存文本关闭

```properties
blacklist nouveau
options nouveau modeset=0
```

在终端输入如下更新

``` sh 
sudo update-initramfs -u
```

更新结束后重启电脑（必须）

``` sh
reboot
```

重启后在终端输入如下，没有任何输出表示屏蔽成功

``` sh
lsmod | grep nouveau
```

## 2. 根据自己的显卡型号下载对应驱动

官网: https://www.nvidia.cn/Download/index.aspx?lang=cn

直接进行这个
```sh
# install 
chmod a+x ./NVIDA...
sudo ./NVIDIA... -no-x-check -no-nouveau-check -no-opengl-files
```

删除 👇
``` sh
# 卸载原有驱动
sudo apt-get remove --purge nvidia*
sudo apt autoremove
sudo apt remove xserver-xorg-video-nouveau

# stop gui
sudo service gdm stop

# install 
chmod a+x ./NVIDA...
sudo ./NVIDIA... -no-x-check -no-nouveau-check -no-opengl-files

sudo service gdm start
```

## ~~3.安装lightdm~~

lightdm是显示管理器，主要管理登录界面，ubuntu20.04、21.04、22.04需要自行安装,然后上下键选择lightdm即可

``` sh
sudo apt-get install lightdm
```

---

---

以下这个跳过

```shell
sudo vim /etc/modprobe.d/blacklist.conf
```

向该文件中添加:

```properties
#blacklist vga16fb
blacklist nouveau
blacklist rivafb
blacklist rivatv
blacklist nvidiafb

# 或
blacklist amd76x_edac
blacklist nouveau
options nouveau modeset=0
```

驱动安装

```shell
sudo add-apt-repository ppa:graphics-drivers/ppa  # 添加Nvidia驱动源
sudo apt update
ubuntu-drivers devices #查看适合驱动
lspci | grep -i vga
```

---

(附: 一个错误解决方案记录)
`sudo update-initramfs -u` 报错后

```shell
sudo update-initramfs -u
blkid | awk -F\" '/swap/ {print $2}'
printf "RESUME=UUID=$(blkid | awk -F\" '/swap/ {print $2}')\n" | sudo tee /etc/initramfs-tools/conf.d/resume
sudo update-initramfs -u
```

# 二. CUDA

## 1. 网址: 

官网: https://developer.nvidia.com/cuda-toolkit-archive

samples: https://github.com/NVIDIA/cuda-samples  (示例， 用来测试)

## 2. runfile(ubuntu 20.04): 

跟着官网命令做(选择runfile)

```shell
# wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
# sudo sh cuda_11.8.0_520.61.05_linux.run
# sudo bash cuda_10.2.89_440.33.01_linux.run --toolkit --silent --override  # ||
```
关于下载cuda时出现段错误核心转储的问题
查看用户限制 ulimit -a  发现stack size为8192
修改栈限制为无限  ulimit -s unlimited  之后便可正常下载
## 3. 配置系统变量

```shell
# 这三个文件只用选一个添加，这里建议添加到~/.bashrc 或 /etc/profile
sudo vim /etc/profile
sudo vim ~/.bashrc
sudo vim /etc/bash.bashrc
# vim 不熟练就用gedit

# 添加到系统变量
export CUDA_HOME=/usr/local/cuda 
export PATH=$PATH:$CUDA_HOME/bin 
export LD_LIBRARY_PATH=$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# --end--

source /etc/bash.bashrc  # 更新环境变量
```

## 4. 测试CUDA

用下载好的`samples`测试
```shell
# 这个要自己下载(上面已经给出网址)
cd /usr/local/cuda/samples/1_Utilities/deviceQuery # 根据自己下载的路径调整路径
sudo make
./deviceQuery
```

# 三. cuDNN

官网: https://developer.nvidia.com/rdp/cudnn-download

文档: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

## 1.1 解压

```shell
tar -xf archive.tar.xz
```

## 1.2

```shell
cd cudnn<...>
sudo cp ./include/cudnn*.h /usr/local/cuda-11.8/include/ 
sudo cp ./lib64/libcudnn* /usr/local/cuda-11.8/lib64/ 
sudo chmod a+r /usr/local/cuda-11.8/include/cudnn*.h 
sudo chmod a+r /usr/local/cuda-11.8/lib64/libcudnn*
```



## 2. 查看cuDNN 版本

```shell
cat /usr/local/cuda/include/cudnn_version.h | grep CUDNN_MAJOR -A 2
```

# 四. 安装Qt、OpenCV依赖包

```shell
sudo apt install -y \
                    git \
                    vim \
                    htop \
                    cmake \
                    cmake-gui \
                    screen \
                    libavcodec-dev \
                    libavformat-dev \
                    libavutil-dev \
                    libeigen3-dev \
                    libglew-dev \
                    libgtk2.0-dev \
                    libgtk-3-dev \
                    libjpeg-dev \
                    libpostproc-dev \
                    libswscale-dev \
                    libtbb-dev \
                    libtiff5-dev \
                    libv4l-dev \
                    libxvidcore-dev \
                    libx264-dev \
                    zlib1g-dev \
                    pkg-config \
                    libxcb*
sudo apt update
sudo apt install python3-pip
sudo -H pip3 install Cython -i https://pypi.tuna.tsinghua.edu.cn/simple
sudo -H pip3 install numpy -i https://pypi.tuna.tsinghua.edu.cn/simple
```

# 五. Qt

## 1. 网址: 

https://www.qt.io/download-open-source

https://download.qt.io/archive/qt  # 已失效

~~https://blog.csdn.net/seedlint/article/details/119853636~~

## 1.1 install

**安装到: /usr/local/Qt**

```shell
sudo chmod a+x <filename>.run
sudo ./<filename>.run --mirror https://mirrors.tuna.tsinghua.edu.cn/qt # 加代理
```

## 1.2 配置环境变量

```sh
vim ~/.bashrc
# 或 配置在 /etc/profile
sudo vim /etc/profile

# Qt
export QT_HOME=/usr/local/Qt/5.15.2
export PATH=${QT_HOME}/gcc_64/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=${QT_HOME}/gcc_64/lib${LD_LIBRARY_PATH:+:${PATH}}
export CMAKE_PREFIX_PATH=${QT_HOME}/gcc_64/lib/cmake${CMAKE_PREFIX_PATH:+:${CMAKE_PREFIX_PATH}}
```

## ~~1.3 open-GL~~

```sh
# 对于Ubuntu，Qt得再安装缺少的open-GL，不然后面会遇到问题?
sudo apt-get install mesa-common-dev
```
# 六. Realsense库

精简版( 看完这个, 下面就不用看了 )

```sh
sudo apt update && sudo apt upgrade

sudo apt install git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev

git clone https://github.com/IntelRealSense/librealsense.git

cd librealsense
mkdir build && cd build
cmake .. -DBUILD_EXAMPLES=true
make -j$(nproc)
sudo make install

# 安装 udev 规则
sudo cp ../config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger

# 测试 (需要摄像头)
realsense-viewer


# 如果安装出现问题,可以尝试运行  scripts下面的这个脚本
scripts/patch-realsense-ubuntu-lts.sh
```



## 0. 网址: 

官网教程：https://dev.intelrealsense.com/docs/compiling-librealsense-for-linux-ubuntu-guide

Github realsense的源码包: https://github.com/IntelRealSense/librealsense

CSDN教程: https://blog.csdn.net/qq_38337524/article/details/115311167

进到源码包根目录下（不连接摄像头）

## 1. 安装构建所需的核心包：

```shell
sudo apt-get install git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev
```

## 2. 安装位于 librealsense 源目录中的 Intel Realsense 权限脚本：

```
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && udevadm trigger
```

构建和应用补丁内核模块：

```shell
./scripts/patch-realsense-ubuntu-lts.sh
```

## 3. CMake

1>. 导航到librealsense根目录并运行

```
mkdir build && cd build
```

2>. 运行 CMake：

cmake ../- 默认构建设置为在调试模式下生成核心共享对象和单元测试二进制文件。用于-DCMAKE_BUILD_TYPE=Release构建优化。

```shell
sudo make uninstall && make clean && make && sudo make install
```


共享对象将安装/usr/local/lib在/usr/local/include.

二进制演示、教程和测试文件将被复制到/usr/local/bin

提示：用make -jX并行编译，其中X表示可用的 CPU 内核数：

```shell
sudo make uninstall && make clean && make **-j8** && sudo make install
```

安装完成后可在终端里输入realsense-viewer进行尝试检查是否安装完成

# 七. OpenCV

CSDN网址: https://blog.csdn.net/qq_25014669/article/details/104651894?spm=1001.2014.3001.5501

---

代理网址:  https://ghproxy.com/

使用方法(例): 下载时哪个报错往哪加代理

"https://raw.githubusercontent.com/opencv/opencv_3rdparty/${IPPICV_COMMIT}/ippicv/" 

"https://ghproxy.com/https://raw.githubusercontent.com/opencv/opencv_3rdparty/${IPPICV_COMMIT}/ippicv/"

搜索`OPENCV_EXTRA_MODULES_PATH`，定位到opencv_contrib-4.1.1(扩展包)/modules


# 八. 安装日志库spdlog、队内库(kdrobotcpplib(依赖于spdlog))


```shell
# 解压

mkdir build && cd build
cmake ../
sudo make install
sudo vim /etc/profile # 配置环境变量
```

```properties
# kdrobotcpplibs
export KDROBOT_CPP_LIBS_HOME=/usr/local/KdrobotCppLibs
export PATH=${KDROBOT_CPP_LIBS_HOME}/bin${PATH:+:${PATH}}
export PATH=${KDROBOT_CPP_LIBS_HOME}/bin/Realsense${PATH:+:${PATH}}
export CMAKE_PREFIX_PATH=${KDROBOT_CPP_LIBS_HOME}/lib/cmake${CMAKE_PREFIX_PATH:+:${CMAKE_PREFIX_PATH}}
```

=================================================================================

安装队内库时报错：

error: ld returned 1 exit status

肯定是环境变量没配号

=============================end===============================================	

# 九. yolov3()

官网：https://pjreddie.com/darknet/

安装教程: https://pjreddie.com/darknet/install/

# 十. anaconda(conda)(python的包管理系统)

1. 官网 https://www.anaconda.com/ 
2. .sh文件执行

  ```sh
bash filename.sh  # 1.
# 或(其实应该是一致的)
# echo $SHELL   -->  /bin/bash默认 shell 就是bash
sh filename.sh    # 2.

# 或 (此时会使用脚本中指定的解释器)
chmod a+x filename.sh  # 3.
./filename.sh
  ```
查看Anaconda中创建的虚拟环境列表，可以使用以下命令：
conda info --envs


(另附: ) 关于Python环境的搭建:

```shell
sudo apt update
sudo apt install python3-dev python3-pip python3-venv
```

# 十一. TensorRT(intel)

官网: https://developer.nvidia.com/tensorrt

安装指导: https://docs.nvidia.com/deeplearning/tensorrt/install-guide/index.html 

选择下载版本时 对应cuda

下载 -> 解压 -> 配置环境

```sh
# TensorRT
export TENSORRT_HOME=/usr/local/TensorRT-8.6.1.6
export PATH=${TENSORRT_HOME}/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=${TENSORRT_HOME}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

# 十二. Pytorch(依赖anaconda)

官网：https://pytorch.org/get-started/locally/

```sh
conda create --name pytorch python=3.9
conda activate pytorch
# 然后执行从官网上找到的命令
```
在终端运行：
```sh
python
import torch
print(torch.__version__)  来查看pytorch版本
torch.cuda.is_available()  若返回True则说明 PyTorch 支持 CUDA 并且 CUDA 已正确配置。如果返回 False，则意味着 CUDA 配置可能存在问题。
```

## 12.2 Yolov5

官网: https://pytorch.org/hub/ultralytics_yolov5/

https://docs.ultralytics.com/yolov5/tutorials/pytorch_hub_model_loading/

```sh
conda create --name yolov5 python=3.9 -y
conda activate yolov5
pip install -U ultralytics
```

# 十三. TensorFlow(依赖anaconda): 

官网: https://www.tensorflow.org/install/pip 

```sh
conda create --name tensorflow python=3.9
conda activate tensorflow
# 然后执行从官网上找到的命令
pip install tensorflow==2.12.*
```
## 验证安装
### 验证 CPU 设置：

```sh
python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
# 如果返回张量，则说明您已成功安装 TensorFlow
```

### 验证 GPU 设置：

```sh
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
# 如果返回 GPU 设备列表，则表明您已成功安装 TensorFlow
```

下载教程(以及一些学习教程):

https://tensorflow.cn.google/install/pip?hl=zh-cn#system-install

https://tensorflow.google.cn/tutorials

/**
知乎的一些教程: 

https://zhuanlan.zhihu.com/p/371239130

https://zhuanlan.zhihu.com/p/297002406
*/

# ~~十四. deep-wine(跳过)~~

1. 卸载原来的depp-wine
sudo apt remove *deepin*wine* udis86
sudo apt autoremove -y
2. 下载deep-wine
```shell
cd ~
wget https://deepin-wine.i-m.dev/setup.sh
chmod a+x setup.sh
./setup.sh
```

3. 下载TIM

```shell
sudo apt-get install -y com.qq.office.deepin
reboot
```

完成后会输出:

大功告成，现在可以试试安装更新deepin-wine软件了，如：
微信：sudo apt-get install com.qq.weixin.deepin
QQ：sudo apt-get install com.qq.im.deepin
TIM：sudo apt-get install com.qq.office.deepin
钉钉：sudo apt-get install com.dingtalk.deepin
完整列表见 https://deepin-wine.i-m.dev/

🌟 安装后需要注销重登录才能显示应用图标。
🌟 无法安装？无法启动？无法正常使用？切记先去github主页看【常见问题】章节，再找找相关issue，也许早已经有了解决方案了。

如果觉得有用，不妨来给项目加个star：https://github.com/zq1997/deepin-wine

# 十五. VScode

1. https://code.visualstudio.com/Download

#  十六. Jetbrains IDE

Clion: https://www.jetbrains.com/clion/

Pycharm: https://www.jetbrains.com/pycharm/download/#section=linux

下载完成后申请***学生认证***

# 十七. Docker

Download: https://docs.docker.com/engine/install/ubuntu/

---

> ***视觉环境配置到此结束***

----

# 十八. 类似everything

https://www.jianshu.com/p/4a62c38bec7e

http://ww1.fsearch.org/
https://github.com/DoTheEvo/ANGRYsearch

### FSearch

```sh
git clone https://github.com/cboxdoerfer/fsearch.git  # 
sudo apt install fsearch
```

# 十九. C++执行python(Clion)

https://blog.csdn.net/qq_38638132/article/details/105597856 

# 20. flameshot( 截图 )

```sh
sudo apt install flameshot
```
