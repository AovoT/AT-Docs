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

# 串口驱动

## 1.`CH341SER`驱动

windows: https://www.wch.cn/download/CH341SER_EXE.html

Linux: https://www.wch.cn/download/CH341SER_LINUX_ZIP.html

Android: https://www.wch.cn/download/CH341SER_ANDROID_ZIP.html

Mac: https://www.wch.cn/download/CH341SER_MAC_ZIP.html

系统默认的驱动目录: `/lib/modules/$(uname -r)/kernel/drivers`

旧驱动路径: `/lib/modules/$(uname -r)/kernel/drivers/usb/serial/ch341.ko`

```shell
# 解压文件夹
make
sudo cp ch341.ko /lib/modules/$(uname -r)/kernel/drivers/usb/serial
sudo depmod
```



## 2. 驱动设备规则

```shell
git clone https://github.com/Xueming10wu/ROS-WT931.git --depth=1

# 进入上面下载的文件夹内
sudo cp wt931.rules /etc/udev/rules.d/  # 复制设备规则

# 当前用户加入 串口组,赋予权限
sudo usermod -aG dialout <用户名>
# 设置开机自动加载设备规则
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

# 自己建文件夹
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

# 前提只装ROS1,装好Ceres库再执行下面语句
cd ..
catkin_make -DCMAKE_BUILD_TYPE=Release -j$(nproc)
```

```shell
# 安装Ceres库
# 安装依赖
sudo apt-get install  liblapack-dev libsuitesparse-dev libcxsparse3 libgflags-dev libgoogle-glog-dev libgtest-dev

# 下载源码
git clone https://github.com/ceres-solver/ceres-solver

# 进入下载路径，编译
cd ceres-solver/
mkdir build
cd build
cmake ..
make -j8  # 巨慢
sudo make install
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

## 3. IMU的标定

```shell
touch kalibr_ws/src/imu_utils/launch/my_imu.launch
```

给出模版

```xml
<launch>
    <node pkg="imu_utils" type="imu_an" name="imu_an" output="screen">
        <!--imu数据topic-->
        <param name="imu_topic" type="string" value= "/imu/data"/>
        <!--imu名称-->
        <param name="imu_name" type="string" value= "wt931"/>
        <!--标定数据保存目录-->
        <param name="data_save_path" type="string" value= "$(find imu_utils)/data/my_imu/"/>
        <!--数据时间跨度,越长越好. 此处给出的值为3小时左右(一般2~3小时)-->
        <param name="max_time_min" type="int" value= "200"/>
        <param name="max_cluster" type="int" value= "100"/>
    </node>
</launch>
```

```shell
# 静止状态采集IMU数据，录制为ros包  200min
rosbag record /imu/data -O imu_xsens.bag
```

```shell
# /imu_data 话题发布要标定的imu数据
roslaunch imu_utils my_imu.launch
rosbag play -r 200 imu_xsens.bag
# catkin_ws/src/imu_utils/data/my_imu 文件夹下会出现一系列data文件，其中xsens_imu_param.yaml中保存噪声和随机游走的系数值
```

标定结果参考

```yaml
---
type: IMU
name: wt931
Gyr:
   unit: " rad/s"
   avg-axis:
      gyr_n: 8.7781290786757421e-03
      gyr_w: 1.0505259325408968e-04
   x-axis:
      gyr_n: 1.1836859031977254e-02
      gyr_w: 2.0684853908769991e-05
   y-axis:
      gyr_n: 4.5088607991391350e-03
      gyr_w: 8.6841739796681073e-05
   z-axis:
      gyr_n: 9.9886674049108389e-03
      gyr_w: 2.0763118605681793e-04
Acc:
   unit: " m/s^2"
   avg-axis:
      acc_n: 4.6909581439534775e-02
      acc_w: 1.9815501639005527e-03
   x-axis:
      acc_n: 2.2916632270934875e-02
      acc_w: 8.3015166132511967e-04
   y-axis:
      acc_n: 6.9477580275638773e-02
      acc_w: 2.9812984232055429e-03
   z-axis:
      acc_n: 4.8334531772030669e-02
      acc_w: 2.1332004071709953e-03
```

# 二. Kalibr编译

相机标定

github:

- https://github.com/ethz-asl/kalibr

- https://github.com/ori-drs/kalibr

## 1.依赖

```shell
#####################
# @warngin: 尚不完善 #
#####################
sudo apt update

sudo apt install -y dpkg-dev build-essential python3-dev freeglut3-dev libgl1-mesa-dev libglu1-mesa-dev libgstreamer-plugins-base1.0-dev libgtk-3-dev libjpeg-dev libnotify-dev libpng-dev libsdl2-dev libsm-dev libtiff-dev libwebkit2gtk-4.0-dev libxtst-dev
0-dev libgtk-3-dev libjpeg-dev libnotify-dev libpng-dev libsdl2-dev libsm-dev libtiff-dev libwebkit2gtk-4.0-dev libxtst-dev

sudo apt install -y python3-setuptools python3-rosinstall ipython3 libeigen3-dev libboost-all-dev doxygen libopencv-dev ros-noetic-vision-opencv ros-noetic-image-transport-plugins ros-noetic-cmake-modules python3-software-properties software-properties-common libpoco-dev python3-matplotlib python3-scipy python3-git python3-pip libtbb-dev libblas-dev liblapack-dev libv4l-dev python3-catkin-tools python3-igraph libsuitesparse-dev libgtk-3-dev

pip3 install wxPython opencv-python matplotlib pycryptodomex gnupg scipy python-igraph pycairo

pip3 install --upgrade pip setuptools sip

# 报错ERROR: launchpadlib 1.10.13 requires testresources, which is not installed.
# 安装依赖项 testresources 即可解决
pip install testresources
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
catkin_make -DCMAKE_BUILD_TYPE=Release -j16  # 不要弄32，电脑会崩溃的
```

## 3. 使用

wiki: https://github.com/ethz-asl/kalibr/wiki

**听不懂英文解决办法：**

使用谷歌浏览器，打开设置，左侧选择无障碍，开启实时字幕

### 3.1 前期准备

标定板下载，yaml参数：https://github.com/ethz-asl/kalibr/wiki/downloads

修改tagsize和tagspacing参数，由下图测量得：

![](/home/mzy/Pictures/picture1.png)

### 3.2 具体实施

对单目相机标定

```shell
# 运行相机节点
rosrun sensor_driver stereo_left_node

# 修改话题频率4(官方推荐)
rosrun topic_tools throttle messages /stereo_left_node/left 4.0 /left  

# 录制bag数据
rosbag record -0 stereo_calibar.bag /left_img  # 结果保存到当前目录

# 启动ros相关指令
source devel/setup.bash

# 进入到kalibr工具目录下 (/home/mzy/kalibr_ws/src/kalibr)
rosrun kalibr kalibr_calibrate_cameras --bag xxx/stereo_calibra.bag --topics /left_img --models  omni-radtan --target xxx/april_6x6_80x80cm_A0.yaml

# 结束后会出现三个文件
# camchain的.yaml文件是后续联合标定要继续用到的，里面包含了所需的相机的内外参
```

```shell
# 对参数的说明
1. xxx/stereo_calibra.bag stpe3 录制的bag路径
2. /left_img /right_img 话题名
3. omni-radtan 相机/畸变模型，有几目相机就要写几个
4. xxx/april_6x6_80x80cm_A0.yaml 标定板配置文件 
5. –show-extraction　是在标定过程中的一个显示界面，可以看到图片提取的过程，可以不要；
6. –approx-sync 0.05　时间戳不对齐问题
7. –bag-from-to后面是想要使用数据时间段的起始时间和结束时间，单位：秒(s)，这个参数可以剔除掉刚开始录制和结束时一些出入视野等画面

# 示例
rosrun kalibr kalibr_calibrate_cameras --bag src/data/2021-09-02-16-24-01.bag --topics /left_img  --models omni-radtan  --target src/data/april_6x6_80x80cm_A0.yaml --show-extraction --approx-sync 0.05
```

# 三.IMU-Camera联合标定

IMU-Camera联合标定需要三个文件

- camera.yaml   包含相机内参
- imu.yaml         包含imu的参数
- target.yaml      标定板的参数

### 3.1 参数文件模版

此处给出模版,具体各个参数参看[官方文档](https://github.com/ethz-asl/kalibr/wiki)

```yaml
# camera.yaml
cam0:
  cam_overlaps: []
  camera_model: pinhole  # 相机模型
  distortion_model: radtan # 畸变模型
  intrinsics: [2665.005527408399, 2673.364537791387, 696.8233000000, 500.5147099572225] # fx fy cx cy (fu fv pu pv)
  distortion_coeffs: [-0.303608974614145, 4.163247825941419, -0.008432853056627, -0.003830248744148] # radtan: [k1, k2, r1, r2]
  resolution: [1440, 1080]  # w, h
  rostopic: /img_data
```

```yaml
# imu.yaml

# 这个参数就是上面imu标定结果中的
# ["Acc"]["avg-axis"]["acc_n"]
accelerometer_noise_density: 6.5171752424928772e-02   # Noise density (continuous-time) 
# ["Acc"]["avg-axis"]["acc_n"]
accelerometer_random_walk:   5.1562720247936276e-04   # Bias random walk

# Gyroscopes
# ["Gyr"]["avg-axis"]["gyr_n"]
gyroscope_noise_density:     2.7877322476328376e-03   # Noise density (continuous-time)
# ["Gyr"]["avg-axis"]["gyr_w"]
gyroscope_random_walk:       5.6402564721831790e-05   # Bias random walk

rostopic:                    /imu_data      		  # the IMU ROS topic
update_rate:                 200.0                    # Hz (for discretization of the values above)
```

```yaml
# target.yaml
target_type: 'checkerboard'  # gridtype 棋盘格模型
targetCols: 11               # number of internal chessboard corners  棋盘格cols角点
targetRows: 8                # number of internal chessboard corners  棋盘格rows角点
rowSpacingMeters: 0.019      # size of one chessboard square [m]      row每一格长度
colSpacingMeters: 0.019      # size of one chessboard square [m]      col..
```

### 3.2 标定

```shell
# 使用 rosbag 录制imu和camera发布的数据
rosbag record /imu_data /img_data -O imu_and_camera_data.bag
# 录制完成后使用Kalibr标定
rosrun kalibr kalibr_calibrate_imu_camera --target target.yaml --imu imu.yaml --imu-models calibrated --cam camera.yaml --bag imu_and_camera_data.bag
```

### 3.3 标定结果参考

```yaml
Calibration results
===================
Normalized Residuals
----------------------------
Reprojection error (cam0):     mean 0.12464439084235639, median 0.1107674111603024, std: 0.07767044030665127
Gyroscope error (imu0):        mean 0.11830174359694699, median 0.06609506861074951, std: 0.15148007441005046
Accelerometer error (imu0):    mean 0.11052030882660645, median 0.08276858319340052, std: 0.09441104533152342

Residuals
----------------------------
Reprojection error (cam0) [px]:     mean 0.12464439084235639, median 0.1107674111603024, std: 0.07767044030665127
Gyroscope error (imu0) [rad/s]:     mean 0.0046639856150579775, median 0.002605764208151208, std: 0.005972024304421326
Accelerometer error (imu0) [m/s^2]: mean 0.10186300565082598, median 0.07628513480511141, std: 0.08701561682381204

Transformation (cam0):
-----------------------
T_ci:  (imu0 to cam0): 
[[ 0.99026869 -0.0122407  -0.13862928 -0.0135453 ]
 [ 0.13896297  0.03283526  0.98975307  0.03876878]
 [-0.00756335 -0.99938582  0.03421674 -0.04030529]
 [ 0.          0.          0.          1.        ]]

T_ic:  (cam0 to imu0): 
[[ 0.99026869  0.13896297 -0.00756335  0.00772121]
 [-0.0122407   0.03283526 -0.99938582 -0.04171932]
 [-0.13862928  0.98975307  0.03421674 -0.03887018]
 [ 0.          0.          0.          1.        ]]

timeshift cam0 to imu0: [s] (t_imu = t_cam + shift)
0.0004378314222498133


Gravity vector in target coords: [m/s^2]
[ 9.14370177  0.07435722 -3.54338987]


Calibration configuration
=========================

cam0
-----
  Camera model: pinhole
  Focal length: [697.7864797135014, 696.3340055344548]
  Principal point: [345.1544, 297.2640885869261]
  Distortion model: radtan
  Distortion coefficients: [-0.4201, 0.2024, -0.0005160242774163281, 0.003750181726942]
  Type: checkerboard
  Rows
    Count: 8
    Distance: 0.019 [m]
  Cols
    Count: 11
    Distance: 0.019 [m]



IMU configuration
=================

IMU0:
 ----------------------------
  Model: calibrated
  Update rate: 200.0
  Accelerometer:
    Noise density: 0.06517175242492877 
    Noise density (discrete): 0.9216677616295591 
    Random walk: 0.0005156272024793628
  Gyroscope:
    Noise density: 0.0027877322476328376
    Noise density (discrete): 0.039424487528671906 
    Random walk: 5.640256472183179e-05
  T_i_b
    [[1. 0. 0. 0.]
     [0. 1. 0. 0.]
     [0. 0. 1. 0.]
     [0. 0. 0. 1.]]
  time offset with respect to IMU0: 0.0 [s]

```

# 四，补充

供参考：

https://blog.csdn.net/qq_43200940/article/details/127073801?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522171478398216800227496047%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fall.%2522%257D&request_id=171478398216800227496047&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~rank_v31_ecpm-1-127073801-null-null.142

