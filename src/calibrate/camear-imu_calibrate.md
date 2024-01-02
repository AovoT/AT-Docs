> 相机-IMU 联合标定

# 环境

`Ubuntu` 20.04

`ROSNoetic`

`OpenCV4`

`Python3`

```shell
cd ~
mkdir -p kalibr_ws/src
```

# 依赖

## 1.`CH341SER`驱动

windows: https://www.wch.cn/download/CH341SER_EXE.html

Linux: https://www.wch.cn/download/CH341SER_LINUX_ZIP.html

Android: https://www.wch.cn/download/CH341SER_ANDROID_ZIP.html

Mac: https://www.wch.cn/download/CH341SER_MAC_ZIP.html

系统默认的驱动目录: `/lib/modules/$(uname -r)/kernel/drivers`

旧驱动路径: `/lib/modules/$(uname -r)/kernel/drivers/usb/serial/ch341.ko`

```shell
cp ch341.ko /lib/modules/$(uname -r)/kernel/drivers/usb/serial
depmod
```



## 2. 驱动设备规则

```shell
git clone https://github.com/Xueming10wu/ROS-WT931.git --depth=1

sudo cp wt931.rules /etc/udev/rules.d/  # 复制设备规则

# 设置开机自动加载设备规则
sudo usermod -aG dialout <用户名>
sudo service udev reload 
sudo service udev restart
reboot

# 开机后检查是否成功加载设备规则
>>> ls /dev/wt931
[out]: /dev/wt931  # 如果有错 -> 更换USB数据线 || 再检查一遍操作
```

# 一. `IMU`标定

## 1.`code_utils`

```shell
sudo apt install -y libdw-dev

cd ~/kalibr_ws/src
git clone https://github.com/gaowenliang/code_utils.git --depth=1

vim code_utils/CMakeLists.txt
################
# 将测试例程注释 #
################
################# CMakeLists.txt ############################
add_executable(matIO_test   src/mat_io_test.cpp )
target_link_libraries(matIO_test dw ${OpenCV_LIBS})

add_executable(sumpixel_test   src/sumpixel_test.cpp )
target_link_libraries(sumpixel_test dw ${OpenCV_LIBS})
###################### end #####################################

cd ..
catkin_make -DCMAKE_BUILD_TYPE=Release -j$(nproc)
```

## 2.`imu_utils`

```shell
cd ~/kalibr_ws/src
git clone https://github.com/gaowenliang/imu_utils.git --depth=1

vim imu_utils/src/imu_an.cpp
#########################
#  添加 <fstream> 头文件 #
#########################
# #include <fstream>


```

# 二. Kalibr编译

github:

- https://github.com/ethz-asl/kalibr

- https://github.com/ori-drs/kalibr

## 1.依赖

```shell
sudo apt update

sudo apt install -y dpkg-dev build-essential python3-dev freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev libgstreamer-plugins-base1.0-dev libgtk-3-dev libjpeg-dev libnotify-dev libpng-dev libsdl2-dev libsm-dev libtiff-dev libwebkit2gtk-4.0-dev libxtst-dev

sudo apt install -y python3-setuptools python3-rosinstall ipython3 libeigen3-dev libboost-all-dev doxygen libopencv-dev ros-noetic-vision-opencv ros-noetic-image-transport-plugins ros-noetic-cmake-modules python3-software-properties software-properties-common libpoco-dev python3-matplotlib python3-scipy python3-git python3-pip libtbb-dev libblas-dev liblapack-dev libv4l-dev python3-catkin-tools python3-igraph libsuitesparse-dev libgtk-3-dev

pip3 install wxPython opencv-python matplotlib pycryptodomex gnupg scipy python-igraph pycairo

pip3 install --upgrade pip setuptools sip
```

```shell
# AttributeError: module 'numpy' has no attribute 'typeDict
pip install --upgrade scipy

#################
#    wxPython   #
#################
pip install -U \
    -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04 \
    wxPython
```

## 2. 编译

```shell
mkdir ~/kalibr_ws/src && cd ~/kalibr_ws/src
git clone --recursive https://github.com/ori-drs/kalibr && cd ..
# source /opt/ros/noetic/setup.bash
catkin__make -DCMAKE_BUILD_TYPE=Release -j$(nproc)
```

## 3. 使用

wiki: https://github.com/ethz-asl/kalibr/wiki
