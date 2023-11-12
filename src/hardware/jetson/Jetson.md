# Jetson刷机指南

```mark
Jetson 系统监视程序Jtop
https://www.jianshu.com/p/497a9f6e34fd
```



序：目前队里的jetson型号为Xavier NX(显存8GB),一共四个（RM2个，RC两个)，均购于瑞泰新时代公司,搭载6002E载板（第三方开发套件），因为NVIDIA官方仅发布核心模组，大多数模组都没有开发套件出售，就算有官方套件，价格也会远远大于第三方开发套件。
![核心模块规格](/home/zps/AT-Docs/img/hardware/jetson/核心模块规格.png)

![](/home/zps/AT-Docs/img/hardware/jetson/载板规格.png)


瑞泰官网:https://realtimes.cn/   云盘访问密码为：realtimes2022


NVIDIA 的 Jetson 系列是一系列高性能嵌入式计算平台，旨在用于构建机器学习、深度学习和计算机视觉应用程序。Jetson 平台具有强大的 GPU 和 CPU，使其能够在边缘设备上进行高性能的 AI 推断和数据处理。Jetson 系列平台通常使用 NVIDIA 的深度学习加速库 cuDNN 和 CUDA，使其能够在硬件级别加速深度学习任务。它们还提供了丰富的软件支持，包括 JetPack SDK，其中包括了 TensorRT、OpenCV 和各种 AI 模型。

## 1.环境烧录

参考  Xavier_NX系统烧录说明手册，位于帮助文档->中文->Jetson烧录与备份

```sh	
sudo tar -vxf Jetson_Linux_R35.3.1_aarch64.tbz2
cd Linux_for_Tegra/rootfs/
sudo tar -jxpf ../../Tegra_Linux_Sample-Root-Filesystem_R35.3.1_aarch64.tbz2 
cd ../..
sudo tar -vxf Realtimes_L4T_R35.3.1_rtso-6002_xavier-nx_20230419.tbz2
cd Realtimes_L4T_R35.3.1_rtso-6002/
sudo ./install.sh # sudo apt-get install qemu-user-static
# 使nx进入recovery模式
lsusb
cd ../Linux_for_Tegra/
sudo ./flash.sh rtso-6002e-v1.2 mmcblk0p1 # 对于rtso-***   ls看载板名去掉.conf
```



注意事项：1.服务器主机（即你的笔记本电脑）：不限于官方文档给的16.04和18.04，Ubuntu别的系统也可以进行烧录，我用的20.04也可以进行烧录
				  2.烧录一共需要三个软件包，结合烧录说明手册在官方网站里都可以找到
				  3.推荐烧录的系统为3531，队库里已经提供，位于AT-Docs/src/hardware/jetson/software_package/System_burning
				  4.如果按照文档给出的进入recovery模式的方法进不去recovery模式的话，就试试一下的方法：先连上适配器，接着马上按住中间的按钮，按三秒后，按一下第一个按钮，按一下后松开，中间的按钮一直按着，直到松开第一个按钮后两秒后松开
之后的烧录环境步骤参考文档或视频就行，很详细，没有什么注意事项，出现小问题的话搜一下应该就能解决，视频网址：https://www.bilibili.com/video/BV1D14y1m7nG/?spm_id_from=333.999.0.0&vd_source=d9f539810e996eac76f619a3a7c90193

## 2.设置从EMMC卡启动系统

在烧录完环境后，根目录的内存很小，所以要设置从EMMC卡启动系统
参考  6002E-35.1从EMMC启动系统-V1.0.pdf，位于帮助文档->中文->Jetson从外部存储设备启动系统
同样给出视频教程：https://www.bilibili.com/video/BV1gr4y1R789/?spm_id_from=333.999.0.0&vd_source=d9f539810e996eac76f619a3a7c90193
没有什么大问题，具体流程这里不再赘述

## 3.Jetpack安装

[sdkmanager下载网址](https://developer.nvidia.com/sdk-manager)
注意事项：1.在安装jetpack之前要先确定Xavier设备L4T系统版本与jetpack版本的对应关系
				  2.在往jetson上烧录的时候Connection要选择Internet，见下图

![img](/home/zps/AT-Docs/img/hardware/jetson/Jetpack安装.jpg)

## 4.Opencv和Qt的安装

参考  Jetson安装opencv4.5.1和QT5方法配置vnc和中文输入法.pdf，位于帮助文档->中文->Jetson系统软件配置
opencv软件包位于AT-Docs/src/hardware/jetson/software_package/jetson_opencv



