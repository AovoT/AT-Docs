# 一、ros里添加队内虚拟串口与单片机通信

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



# 二、ROS Humble下雷达代码配置

1. FAST_LIO

   [源码地址](https://github.com/Ericsii/FAST_LIO)为FAST_LIO的ROS2版本

   在.../src目录下

   ```bash
   # 递归克隆，若忘了加recursive可以
   # 在所克隆项目的目录下运行命令：
   # git submodule update --init
   # 即可将子模块也克隆进本地
   
   git clone --recursive https://github.com/Ericsii/FAST_LIO.git
   cd ..
   colcon build --symlink-install --packages-select fast_lio
   . ./install/setup.bash 
   ```

   添加pcl库

   ```bash
   sudo apt install ros-$ROS_DISTRO-pcl-ros
   ```

2. far_planner

   [源码地址](https://github.com/MichaelFYang/far_planner)

   在.../src目录下

   ```bash
   git clone https://github.com/MichaelFYang/far_planner.git
   git checkout origin humble
   ```
   
   在计算机性能允许的情况下far_planner可以与autonomous_exploration_development_environment一起编译，不允许的话可以如下分开编译：
   
   在工作空间目录下：
   
   ```bash
   colcon list
   
   # 切换新终端
   
   colcon build --symlink-install -cmake-args -DCMAKE_BUILD_TYPE=Release --packages-select 上一个终端中的所有far_planner路径下的功能包
   ```

3. autonomous_exploration_development_environment

   [源码地址]()
   
   ROS环境配置
   
   ```bash
   sudo apt update
   sudo apt install ros-humble-desktop-full ros-humble-gazebo-msgs ros-humble-gazebo-plugins ros-humble-gazebo-ros ros-humble-gazebo-ros2-control ros-humble-gazebo-ros-pkgs python3-colcon-common-extensions
   ```
   
   拉取代码：
   
   ```bash
   git clone https://github.com/HongbiaoZ/autonomous_exploration_development_environment.git
   git checkout humble
   ```
   
   若选择与far_planner一起编译，则在工作空间目录下：
   
   ```bash
   colcon list
   
   # 切换新终端
   
   colcon build --symlink-install -cmake-args -DCMAKE_BUILD_TYPE=Release --packages-ignore 上一个终端中除far_planner和autonomous_exploration_development_environment路径下所有的功能包
   ```
   
   若选择与far_planner分开编译，则在工作空间目录下：
   
   ```bash
   colcon list
   
   # 切换新终端
   
   colcon build --symlink-install -cmake-args -DCMAKE_BUILD_TYPE=Release --packages-ignore 上一个终端中除autonomous_exploration_development_environment路径下所有的功能包
   ```