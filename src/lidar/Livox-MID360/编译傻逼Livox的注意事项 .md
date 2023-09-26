# 编译傻逼Livox的注意事项

**1.傻逼Livox的LIO_Livox的功能包的工程名字是lio_livox，不是他妈的LIO_Livox，直接用在launch文件里找不到**

**2.编译傻逼Livox的livox_ros_driver2功能包的时候不要用他妈的build.sh直接编译，这个傻逼脚本会把你的所有编译过得文件全寄吧删了，你就用ros1就把package_ROS1.xml改成package.xml，ROS2亦然，然后在CMakeLists.txt里面加一个`set(ROS_EDITION ROS1)`，但事实上这个cmake并不是这么改，我忘了。然后直接catkin_make编译就行了，ros2有ros2的编译方式和set，一个道理**

**3.编译傻逼Livox的LIO_Livox的时候需要先编译livox_ros_driver，要让他先生成.h文件，不能一块编译，要这样`catkin_make -DCATKIN_WHITELIST_PACKAGES="livox_ros_driver"`然后在全部编译**

**4.会出现报错`#error PCL requires C++14 or above`，把用到PCL库的所有功能包的CMakeLists.txt的C++的标准从11改成14或者更高**

**5.出现报错**

```cmake
/home/wang/demo_sentry_ws/src/LIO-Livox/src/lio/PoseEstimation.cpp:190:10: error: ‘LocalParameterization’ is not a member of ‘ceres’
  190 |   ceres::LocalParameterization *quatParam = new ceres::QuaternionParameterization();
      |          ^~~~~~~~~~~~~~~~~~~~~
/home/wang/demo_sentry_ws/src/LIO-Livox/src/lio/PoseEstimation.cpp:190:33: error: ‘quatParam’ was not declared in this scope
  190 |   ceres::LocalParameterization *quatParam = new ceres::QuaternionParameterization();
      |                                 ^~~~~~~~~
/home/wang/demo_sentry_ws/src/LIO-Livox/src/lio/PoseEstimation.cpp:190:49: error: expected type-specifier
  190 |   ceres::LocalParameterization *quatParam = new ceres::QuaternionParameterization();```**


```
**是因为Ceres的版本太高了，人家给LocalParameterization删除了，编译一个低版本的就行了**

[github原文](https://github.com/opencv/opencv_contrib/issues/3218)

```
The latest release of Ceres Solver (v 2.1.0) deprecates the ceres::LocalParameterization API. Going forward this will be removed. libmv uses Ceres Solver to do bundle adjustment. libmv should be updated to use ceres::Manifold (guarded by the ceres version number) instead of ceres::LocalParameterization.
```



以后碰到问题实时更新，yysy，傻逼一个



# ros里添加队内虚拟串口与单片机通信

在此之前：`sudo apt-get install qt5-default`

在CMakeLists.txt中添加

```cmake
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5Core)
find_package(Qt5SerialPort)
find_package(Qt5Network)


# ROS1:
find_package(spdlog)
find_package(loggerFactory)
find_package(Qt_Util)
find_package(VCOMCOMM)

target_link_libraries(${PROJECT_NAME}_node
  ${catkin_LIBRARIES}
  KdrobotCppLibs::loggerFactory
  KdrobotCppLibs::Qt_Util
  KdrobotCppLibs::VCOMCOMM
)

# ROS2:分两部分
#第一部分
find_package(spdlog)
find_package(loggerFactory)
find_package(Qt_Util)
find_package(VCOMCOMM)
# 或者
find_package(spdlog REQUIRED)
find_package(loggerFactory REQUIRED)
find_package(Qt_Util REQUIRED)
find_package(VCOMCOMM REQUIRED)
# 第二部分
link_directories(/usr/local/KdrobotCppLibs/lib/cmake)
target_link_libraries(【node_name】
  KdrobotCppLibs::loggerFactory
  KdrobotCppLibs::Qt_Util
  KdrobotCppLibs::VCOMCOMM
)
```

conda config --set auto_activate_base false

https://www.kdrobot.top/git/KDRobot_RM/VCOMCOMM.git

如果FAST_LIO出现报错Pose6D不存在，多编译几次就好

**5.17**

注意，傻逼livox ros driver2的gitignore里面 有package.xml，如果你通过git去部署PC或者换到别的地方克隆程序，会把package忽略掉，导致pkg不被发现，纯纯的傻逼



**6.19**

# ROS2 humble环境下的雷达配置

1. Lio_SDK2的安装

   具体可见[官方文档](https://github.com/Livox-SDK/Livox-SDK2/blob/master/README.md)

   前期使用鱼香ROS一键安装ROS
   ```bash
   git clone https://github.com/Livox-SDK/Livox-SDK2.git
   cd ./Livox-SDK2/
   mkdir build
   cd build
   cmake .. && make -j
   sudo make install
   ```

2. 构建并运行Livox ROS Driver 2

   具体可见[官方文档](https://github.com/Livox-SDK/livox_ros_driver2)，此处只针对ros humble的配置

   在总工作空间目录下

   ```bash
   git clone https://github.com/Livox-SDK/livox_ros_driver2.git ws_livox/src/livox_ros_driver2
   ```

   会得到一个名叫ws_livox的工作空间，在ws_livox/src/livox_ros_driver2目录下构建

   ```bash
   source /opt/ros/humble/setup.sh
   ./build.sh humble
   ```

   对于MID360，试运行：

   ```bash
   sudo ldconfig
   . ../../install/setup.bash
   ros2 launch livox_ros_driver2 rviz_MID360_launch.py
   ```

3. 构建并运行FAST_LIO

   在ws_livox/src目录下

   ```bash
   # 递归克隆，若忘了加recursive可以
   # 在所克隆项目的目录下运行命令：
   # git submodule update --init
   # 即可将子模块也克隆进本地
   git --recursive clone https://github.com/hku-mars/FAST_LIO.git
   cd ..
   colcon build --symlink-install
   . ./install/setup.bash # use setup.zsh if use zsh
   ```

   添加pcl库

   ```bash
   sudo apt install ros-$ROS_DISTRO-pcl-ros
   ```

   最后，先运行rviz_MID360_launch.py，再运行mapping.launch.py即可





另：附上[犇哥雷达代码仓库](https://github.com/Wangben1019/KDRobot_RM2023Sentry_Navigation.git)
