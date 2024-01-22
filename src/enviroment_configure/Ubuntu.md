> Ubuntu环境配置(包含传统视觉环境配置和深度视觉环境配置)

> 附自动化配置脚本: https://github.com/yxSakana/UbuntuAutoConfigure

# 零. 前期环境准备

1. 制作系统盘
   硬件需要一个u盘和一台电脑，软件需要Rufus(官方推荐烧录软件)和所要制作的Ubuntu版本镜像

   (镜像下载地址): 统一下载20.04的版本
   - https://releases.ubuntu.com/focal/ (20.04)
   - https://ubuntu.com/download/desktop

   (制作Ubuntu启动u盘): [https://ubuntu.com/tutorials/create-a-usb-stick-on-windows#1-overview](#1-overview)

   注意事项：**需要U盘支持被制作为启动盘** (否则可能会无法被检测到)
   
2. 预留磁盘空间给Ubuntu,第一次装都装120G,后期重装自己看情况给

   点击磁盘管理,选择一个存储空间富裕的分区 ，右击 ->“压缩卷,要注意内存在磁盘上需要是连续的，即最好只从一个盘腾地方,压缩完成之后，在你选择压缩的分区上的图形化显示会出现灰色条，即证明成功

   ![](../../img/enviroment_configure/Ubuntu(Vision)/图片1.png)

   ![](../../img/enviroment_configure/Ubuntu(Vision)/图片2.png)

3. BIOS设置(自己查自己牌子的电脑怎么进BIOS)

    禁用电脑的安全引导项 依次选择 Security -> security boot -> disable

4. 插上启动盘后重启

5. 自己查自己牌子的电脑怎么进U盘启动

6. 进入安装界面后
   1. 语言选择 English,后点击Install Ubuntu![](../../img/enviroment_configure/Ubuntu(Vision)/1.jpg)
   2. 键盘布局选择Chinese![](../../img/enviroment_configure/Ubuntu(Vision)/2.jpg)
   3. wifi先别连接
   4. 最小安装、安装时不更新、安装无线模块及第三方库![](../../img/enviroment_configure/Ubuntu(Vision)/3.jpg)
   5. 选择Something else,之后继续点Continue![](../../img/enviroment_configure/Ubuntu(Vision)/4.jpg)
   6. 分区:![](../../img/enviroment_configure/Ubuntu(Vision)/5.jpg)
      1. /boot          2G![](../../img/enviroment_configure/Ubuntu(Vision)/6.jpg)
      2. /swap          2G![](../../img/enviroment_configure/Ubuntu(Vision)/7.jpg)
      3. /home       >= 50G![](../../img/enviroment_configure/Ubuntu(Vision)/9.jpg)
      4. /           >= 60G![](../../img/enviroment_configure/Ubuntu(Vision)/8.jpg)
      5. 之后![](../../img/enviroment_configure/Ubuntu(Vision)/10.jpg)![](../../img/enviroment_configure/Ubuntu(Vision)/11.jpg)![](../../img/enviroment_configure/Ubuntu(Vision)/12.jpg)
      6. 设置名称密码   名称（自己姓名首字母小写）  密码统一设置为aaa![](../../img/enviroment_configure/Ubuntu(Vision)/13.jpg)

7. 安装完成后重启，耐心等待一段英文提示，拔掉U盘后按enter键

8. 再次进入后，打开设置切换语言为中文,换完会提示你登出，登出就行

    ![](../../img/enviroment_configure/Ubuntu(Vision)/15.jpg)

10. 重新登入后***保留英文目录名***   keep old names![](../../img/enviroment_configure/Ubuntu(Vision)/14.jpg)

11. 连接Wifi

12. 系统换源

点击软件与更新

![](../../img/enviroment_configure/Ubuntu(Vision)/换源.jpg)

点击其它

![](../../img/enviroment_configure/Ubuntu(Vision)/18.jpg)

选择阿里源,关闭后会出现重新载入,重新载入即可

![](../../img/enviroment_configure/Ubuntu(Vision)/19.jpg)

```markdown
换源后执行一次  sudo apt update && sudo apt upgrade
```

# 一. 主要流程概述

这是一开始最基本的流程概述，之后按照学习的东西不同再安装其他的

-> 搜狗拼音 -> 双系统时间同步 -> typora

-> N卡 ->  cuda -> cuDNN 

-> Qt、OpenCV依赖包 -> Qt -> OpenCV -> Realsense库

-> 日志库spdlog、队内库(kdrobotcpplib(依赖于spdlog)

视觉环境配置参考CSDN网址: 

https://blog.csdn.net/qq_25014669/article/details/104651894?spm=1001.2014.3001.5501

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

官网网址：https://pinyin.sogou.com/linux?r=pinyin   下载x86_64
![](../../img/enviroment_configure/Ubuntu(Vision)/sougou.png)



官方教程: https://shurufa.sogou.com/linux/guide 

教程中直接往下拉到如图所示，之后跟着教程走就行![](../../img/enviroment_configure/Ubuntu(Vision)/sougou_1.png)

# 三. 双系统时间同步问题

具体为什么安装完双系统后windows系统时间会错误，可以自己去查查

```sh
sudo apt install ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc
```

执行完之后在windows系统中更新一次时间就不会出错了

# 四.Typora安装

```sh
######## 解压方式根据文件类型自行修改命 #######
# install rar unrar
sudo apt install rar unrar
# unrar
mkdir typora
unrar e typora1.2.4\ Linux.rar -d typora
############## end #######################
# install
sudo dpkg -i typora_1.2.4_amd64.deb
# replace asar
sudo cp ./app.asar /usr/share/typora/resources
```

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

# 一. N卡驱动（只适用于NVIDIA独显）

## 1.禁用nouveau(nouveau是通用的驱动程序)

```shell
sudo vim /etc/modprobe.d/blacklist.conf
```

在打开的 `blacklist.conf` 末尾添加如下，保存文本关闭

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

## 2.安装N卡驱动

安装N卡驱动有多种方法，但都要做第一步，即禁用nouveau

1. 从英伟达官方下载驱动并安装，推荐使用这种方法，以下给出网址：

   官网: https://www.nvidia.cn/

   Download: https://www.nvidia.cn/Download/index.aspx?lang=cn

   (根据自己的电脑显卡型号下载合适的驱动)

   ```sh
   # install 
   chmod a+x ./NVIDA...
   sudo ./NVIDIA... -no-x-check -no-nouveau-check -no-opengl-files
   ```

   视频教程: https://www.bilibili.com/video/BV1wY411p7mU/

2. 命令行安装

   ```shell
   ubuntu-drivers devices  # 首先在终端输入这条命令查看适合驱动
   # 查看recommended版本，比如我这里为535看你自己的推荐版本是什么
   ```

   ![](../../img/enviroment_configure/Ubuntu(Vision)/nvidia驱动.png)

   ```shell
   # 之后安装推荐驱动，箭头所指
   sudo apt install nvidia-driver-535-server
   ```

   之后可能会出现报缺少依赖的错误，缺什么就 `sudo apt install` 什么，安装完依赖后再次执行安装驱动的命令

3. ubuntu的UI界面中安装
   打开转件和更新
   ![](../../img/enviroment_configure/Ubuntu(Vision)/nvidia驱动_1.png)

   选择你的推荐版本->应用更改，同样可能会出现缺少依赖的错误，缺少什么就 sudo apt install 什么

   在此给出一个第二种方法和第三种发法的视频教程：https://www.bilibili.com/video/BV1Mg4y1p7uN/?spm_id_from=333.788.top_right_bar_window_history.content.click
   
   ```sh
   dpkg -l | grep nvidia # 查看驱动的版本
   sudo apt-get remove --purge nvidia* # 卸载驱动
   sudo apt remove xserver-xorg-video-nouveau
   # 若是用第二种和第三种方法安装的NVIDIA驱动，在安装cuda时若出现下面这种报错要用到以上三个命令
   Failed to initialize NVML: Driver/library version mismatch
   ```

# 二. CUDA和CUDNN

几个相关教程：https://blog.csdn.net/kunhe0512/article/details/125061911

​          			   https://blog.csdn.net/weixin_60864335/article/details/126671341

## 1.1 cuda网址

官网: https://developer.nvidia.com/cuda-toolkit-archive

samples: https://github.com/NVIDIA/cuda-samples  (示例， 用来测试)

## 1.2. CUDA下载(ubuntu 20.04)

### 1.2.1 runfile

跟着官网命令做(选择runfile)

```shell
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
sudo sh cuda_11.8.0_520.61.05_linux.run
sudo bash cuda_10.2.89_440.33.01_linux.run --toolkit --silent --override  # ||
```
关于下载cuda时出现段错误核心转储的问题
查看用户限制 ulimit -a  发现stack size为8192
修改栈限制为无限  ulimit -s unlimited  之后便可正常下载

23.11.5补：

### 1.2.2 deb包

```sh
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-8-local_11.8.0-520.61.05-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2004-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda
```

## 1.3 配置系统变量

```shell
# 这三个文件只用选一个添加，这里建议添加到~/.bashrc 或 /etc/profile 
# 或 在 /etc/profile.d/ 目录下单独新建 *.sh文件
vim ~/.bashrc
sudo vim /etc/profile
sudo vim /etc/bash.bashrc
# vim 不熟练就用gedit

# 添加到系统变量
export CUDA_HOME=/usr/local/cuda 
export PATH=$PATH:$CUDA_HOME/bin 
export LD_LIBRARY_PATH=$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# --end--

source /etc/bash.bashrc  # 更新环境变量
```

## 1.4 测试CUDA

用下载好的`samples`测试
```shell
# 这个要自己下载(上面已经给出网址)
cd /usr/local/cuda/samples/1_Utilities/deviceQuery # 根据自己下载的路径调整路径
sudo make
./deviceQuery
```

## 2.1 cuDNN网址

官网: https://developer.nvidia.com/rdp/cudnn-download

安装文档：https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html

文档: https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

## 2.2 cuDNN下载

### 2.2.1 runfile

```shell
tar -xf archive.tar.xz

cd cudnn<...>
# 将以下文件复制到 CUDA 工具包目录中
sudo cp ./include/cudnn*.h /usr/local/cuda-11.8/include/ 
sudo cp ./lib64/libcudnn* /usr/local/cuda-11.8/lib64/ 
sudo chmod a+r /usr/local/cuda-11.8/include/cudnn*.h 
sudo chmod a+r /usr/local/cuda-11.8/lib64/libcudnn*

cat /usr/local/cuda/include/cudnn_version.h | grep CUDNN_MAJOR -A 2 # 查看cuDNN 版本
```

### 2.2.2 deb (下载Debian本地存储库安装包。在发出以下命令之前，您必须将`X.Y`和替换`8.x.x.x`为您的特定 CUDA 和 cuDNN 版本。)

```shell
导航到包含 cuDNN Debian 本地安装程序文件的目录
sudo dpkg -i cudnn-local-repo-$distro-8.x.x.x_1.0-1_amd64.deb # 启用本地存储库
sudo cp /var/cudnn-local-repo-*/cudnn-local-*-keyring.gpg /usr/share/keyrings/ # 导入 CUDA GPG 密钥
sudo apt-get update # 刷新存储库元数据
sudo apt-get install libcudnn8=8.x.x.x-1+cudaX.Y # 安装运行时库
sudo apt-get install libcudnn8-dev=8.x.x.x-1+cudaX.Y # 安装开发者库
sudo apt-get install libcudnn8-samples=8.x.x.x-1+cudaX.Y # 安装代码示例
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

## 1.1 网址: 

https://www.qt.io/download-open-source
![](../../img/enviroment_configure/Ubuntu(Vision)/Qt.png)

~~https://blog.csdn.net/seedlint/article/details/119853636~~

## 1.2 install

**安装到: /usr/local/Qt**

```shell
sudo chmod a+x <filename>.run  # 赋予可执行权限
sudo ./<filename>.run --mirror https://mirrors.tuna.tsinghua.edu.cn/qt # 加代理
```

其他镜像
- 阿里云: https://mirrors.aliyun.com/qt/
- 清华大学：https://mirrors.tuna.tsinghua.edu.cn/qt/
- 中国科学技术大学：http://mirrors.ustc.edu.cn/qtproject/
- 北京理工大学：http://mirror.bit.edu.cn/qtproject/
- 中国互联网络信息中心：https://mirrors.cnnic.cn/qt/

开始安装后，首先会显示欢迎信息，并提示需要Qt账号，输入帐号密码后，next，选择自定安装，组件的选择及安装

## 1.3 配置环境变量

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

github: 
- (base): https://github.com/opencv/opencv
- (contrib): https://github.com/opencv/opencv_contrib

CSDN网址: https://blog.csdn.net/qq_25014669/article/details/104651894

---

代理网址:  https://ghproxy.com/

使用方法(例): 下载时哪个报错往哪加代理

"https://raw.githubusercontent.com/opencv/opencv_3rdparty/${IPPICV_COMMIT}/ippicv/" 

"https://ghproxy.com/https://raw.githubusercontent.com/opencv/opencv_3rdparty/${IPPICV_COMMIT}/ippicv/"

搜索`OPENCV_EXTRA_MODULES_PATH`，定位到opencv_contrib-4.1.1(扩展包)/modules


# 八. 安装日志库spdlog、队内库(kdrobotcpplib(依赖于spdlog))

## 8.1 spdlog

```shell
git clone https://github.com/gabime/spdlog --depth=1
cmake -B build && cmake --build build -j$(nproc) && sudo cmake --build build --target install
```

## 8.2 KdRobotCppLibs
```shell
git clone https://github.com/LX050724/KdrobotCppLibs.git --depth=1
cmake -B build && cmake --build && sudo cmake --build build --target install
```

```properties
# 配置环境变量
sudo vim /etc/profile
# kdrobotcpplibs
export KDROBOT_CPP_LIBS_HOME=/usr/local/KdrobotCppLibs
export PATH=${KDROBOT_CPP_LIBS_HOME}/bin${PATH:+:${PATH}}
export PATH=${KDROBOT_CPP_LIBS_HOME}/bin/Realsense${PATH:+:${PATH}}
export CMAKE_PREFIX_PATH=${KDROBOT_CPP_LIBS_HOME}/lib/cmake${CMAKE_PREFIX_PATH:+:${CMAKE_PREFIX_PATH}}
```

# ~~九. YOLOV3~~

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

查看Anaconda中创建的虚拟环境列表，可以使用以下命令：`conda info --envs`


(另附: ) 关于Python环境的搭建:

```shell
sudo apt update
sudo apt install python3-dev python3-pip python3-venv
```

# 十一. Pytorch

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
print(torch.__version__)  # 查看pytorch版本
torch.cuda.is_available()  # 若返回True则说明 PyTorch 支持 CUDA 并且 CUDA 已正确配置。如果返回 False，则意味着 CUDA 配置可能存在问题。
```

## 11.2 Yolov5

官网: https://pytorch.org/hub/ultralytics_yolov5/

相关教程：

- https://www.bilibili.com/video/BV1G24y1G7qm

- en: https://docs.ultralytics.com/
- cn: https://docs.ultralytics.com/zh/

```sh
##########################
# 注意: Yolov5依赖pytorch #
##########################
conda create --name yolov5 python=3.9 -y
conda activate yolov5
pip install -U ultralytics
```

# 十二. TensorFlow: 

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

# 十三. TensorRT(NVIDIA)

## 1.网址

官网: https://developer.nvidia.com/tensorrt

安装教程: https://docs.nvidia.com/deeplearning/tensorrt/install-guide/index.html 

## 2.下载安装

### 2.1 deb

[CSDN教程](https://blog.csdn.net/shanglianlm/article/details/130219640?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522169917148416800186579747%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fall.%2522%257D&request_id=169917148416800186579747&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~rank_v31_ecpm-1-130219640-null-null.142^v96^pc_search_result_base9&utm_term=ubuntu20.04%E5%AE%89%E8%A3%85tensorrt%20cuda11.8&spm=1018.2226.3001.4187)(里面也给出了cuda和cudnn的deb包的安装方式)

```sh
sudo dpkg -i nv-tensorrt-local-repo-${os}-${tag}_1.0-1_amd64.deb
sudo cp /var/nv-tensorrt-local-repo-${os}-${tag}/*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
# 安装 tensorrt
sudo apt-get install tensorrt
# 如果使用 Python
sudo apt-get install python3-libnvinfer-dev
# 如果转换 onnx 模型
sudo apt-get install onnx-graphsurgeon
# 如果转换 TensorFlow 模型
sudo apt-get install uff-converter-tf
# 验证 TensorRT 是否安装成功
dpkg-query -W tensorrt
# 您应该看到类似于以下内容的内容：
tensorrt	8.6.1.6-1+cuda11.8
```

下载 -> 解压 -> 配置环境

```sh
# TensorRT
export TENSORRT_HOME=/usr/local/TensorRT-8.6.1.6
export PATH=${TENSORRT_HOME}/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=${TENSORRT_HOME}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

# ~~十四. deep-wine~~

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

# ~~十九. C++执行python(Clion)~~

https://blog.csdn.net/qq_38638132/article/details/105597856 

# 20. flameshot( 截图软件)

网址：https://github.com/flameshot-org/flameshot/releases

只展示我的安装版本

![](../../img/enviroment_configure/Ubuntu(Vision)/flameshot.png)

```markdown
sudo dpkg -i flameshot-12.1.0-1.ubuntu-20.04.amd64.deb
```

