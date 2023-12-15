# Docker 入门

## Docker重要概念理解

**镜像(Image)**：相当于一个模板。可理解为官方发布可供下载的Windows系统镜像、Ubuntu系统镜像等。

**容器(Container)**：是镜像的运行实例。可以理解为烧录好系统的笔记本、选择好系统的虚拟机等。

**仓库(Repository)**：储存和管理镜像的地方。比如：DockerHub，但现在国内打不开，但也有代理网站可用。

## Docker安装

### 安装

[官网](https://www.docker.com/get-started/)有所有安装方式，初学者建议使用安装脚本安装

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### 测试

在终端中输入：

```bash
docker run hello-world
```

该条命令会运行`hello-world`镜像，会先检查系统中是否存在该镜像：若不存在，则拉取公共镜像。

但一般此时不会成功，而是会返回没有没有权限运行之类的报错。这是因为

> 默认情况下， docker 命令会使用 Unix socket 与 Docker 引擎通讯。 而只有 root 用户和docker 组的用户才可以访问 Docker 引擎的Unix socket。 （可以参考：Docker架构及组件剖析）
>
> docker 组内用户执行命令的时候会自动在所有命令前添加 sudo。因为设计或者其他的原因，Docker 给予所有 docker 组的用户相当大的权力（虽然权力只体现在能访问 /var/run/docker.sock 上面）。
>
> 默认情况下，Docker 软件包是会默认添加一个 docker 用户组的。Docker 守护进程会允许 root 用户和 docker组用户访问 Docker。
> 
> 出于安全考虑，一般 Linux 系统上不会直接使用 root 用户。  因此，更好地做法是将需要使用 docker 的用户加入 docker用户组。

此时需要在终端中进行如下操作

```bash
# 创建docker组（已经存在则不用创建），如果出现重复创建的报错，不用管，继续下一步
sudo groupadd docker
# 添加当前用户到docker组
sudo gpasswd -a ${USER} docker
# 重启 docker服务
sudo systemctl restart docker 
# 切换到docker组
newgrp docker
```

之后再继续进行测试命令就可以啦~

测试成功后会返回以下信息

```bash
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

### 卸载

```bash
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

## Docker重要命令学习

### 查看镜像`docker images`

列出本地主机上的镜像

```bash
nightfall@nightfall:~
> docker images
REPOSITORY            TAG                   IMAGE ID               CREATED          SIZE
hello-world             latest                9c7a54a9a43c   7 months ago     13.3kB
```

* REPOSITORY：镜像的仓库源
* TAG：镜像的标签。同一个仓库源可以有多个不同标签，代表仓库源的不同版本，使用 REPOSITORY:TAG 来定义不同的镜像。
* IMAGE ID：镜像ID
* CREATED：镜像创建时间
* SIZE：镜像大小

### 查找镜像`docker search`

用于查找镜像，比如：查找ROS镜像

```bash
nightfall@nightfall:~
> docker search ros
NAME                                            DESCRIPTION                                                                         STARS     OFFICIAL               AUTOMATED
ros                                             The Robot Operating System (ROS) is an open …        613            [OK]       
osrf/ros                                    The Robot Operating System (ROS) is an open …       148                                                       [OK]
rostlab/pp1cs                        Dockerimage for the exercise of Protein Pred…            0                    
osrf/ros2                                  **Experimental** Docker Images for ROS2 deve…     68                                                         [OK]
rosaenlg/server                   RosaeNLG node.js Server                                                          0                    
rosaenlg/cli                           Command Line Interface for RosaeNLG                              0                    
rosaenlg/server-java         RosaeNLG Java Server                                                                0                    
osrf/ros_legacy                    Legacy docker image archive for Robot Operat…          3                                                         [OK]
..............................
```

* NAME：镜像的仓库源名
* DESCRIPTION：镜像描述
* STARS：类似github的star
* OFFICIAL：是否为官方发布
* AUTOMATED：自动构建

### 下载镜像`docker pull`

从仓库预先下载镜像。比如：拉取ROS2 Humble版本镜像

```bash
docker pull osrf/ros:humble-desktop-full
```

### 删除镜像`docker rmi`

删除hello-world镜像

```
docker rmi hello-world
```

**注意**：若此镜像已经生成容器，则无法直接删除，需要先删除对应容器后才能删除镜像

### 查看容器

#### `docker ps`

查看正在运行的容器

```bash
nightfall@nightfall:~
> docker ps
CONTAINER ID                 IMAGE                 COMMAND        CREATED          STATUS              PORTS                   NAMES
4bdfa3d53102   portainer/portainer   "/portainer"   23 hours ago   Up 2 hours                                           prtainer
```

* CONTAINER ID：容器ID，可以通过id找到唯一的对应容器
* IMAGE （image）：该容器所使用的镜像
* COMMAND （command）：启动容器时运行的命令
* CREATED （created）：容器的创建时间，显示格式为”**时间之前创建“
* STATUS （status）：容器现在的状态，状态有7种：created（已创建）、restarting（重启中）、running（运行中）、removing（迁移中）、paused（暂停）、exited（停止）、dead
* PORTS （ports）: 容器的端口信息和使用的连接类型（tcp\udp）
* NAMES （names）: 镜像自动为容器创建的名字，也唯一代表一个容器

#### `docker pa -a`

查看所有容器

```
nightfall@nightfall:~
> docker ps -a
CONTAINER ID               IMAGE                 COMMAND          CREATED                     STATUS                                  PORTS                             NAMES
d1848da36854          hello-world             "/hello"         4 minutes ago   Exited (0) 4 minutes ago                                                    brave_gates
df8eb733ebcf            hello-world             "/hello"          21 hours ago      Exited (0) 21 hours ago                                                   quizzical_wing
4bdfa3d53102   portainer/portainer   "/portainer"   23 hours ago              Up 2 hours                             prtainer
```

### 删除容器`docker rm ${CONTAINER ID}`

删除后返回容器ID

```bash
nightfall@nightfall:~
> docker rm d1848da36854
d1848da36854
```

### 启动镜像`docker run`

对于Docker来说，image是静态的，类似于操作系统快照，而container则是动态的，是image的运行实例。因此启动镜像就需要创建容器。

```bash
nightfall@nightfall:~
> docker run -t -i osrf/ros:humble-desktop-full /bin/bash
root@3635c9ed27b3:/# 
```

* docker run：启动container(这种方式是基于镜像的启动，会创建一个新的容器)
* ubuntu：你想要启动的image
* -t：进入终端
* -i：获得一个交互式的连接，通过获取container的输入
* /bin/bash：在container中启动一个bash shell
* 3635c9ed27b3：容器ID

此时容器就已经在运行了，进入到了容器的bash命令行中。退出时可以直接`exit`。

### 保存容器`docker commit`

当对容器修改后，直接exit再用`docker run`运行镜像，是不会保存任何操作的。可以将该容器重新打包成另一个镜像保存。

```bash
docker commit 3635c9ed27b3 wang:humble2.0
```

* 3635c9ed27b3：容器ID
* wang:humble2.0：新镜像源:镜像TAG

### 暂停容器`docker pause`

暂停一个Docker容器时，容器内的数据并不会丢失。只有当容器关闭后，其内部的内容才会丢失。然而，容器的退出并不等同于数据的丢失。

即使容器已经退出运行，仍然可以通过`docker start`命令来重新启动它，并且其中的数据也不会丢失。

**但若想永久储存数据，仍建议将修改后的容器状态保存为新镜像。**

```bash
docker pause [容器ID或名称] 
```

### 停止容器`docker stop`

```
docker stop [容器ID或名称] 
```

### 启动容器`docker start`

暂停或停止的容器都可以通过该命令重新启动

```
docker start [容器ID或名称] 
```

### 重启容器`docker restart`

```bash
docker restart [容器ID或名称] 
```



# Docker + ROS

Docker入门中已经下载了ROS2的镜像，此处就以ROS2 Humble为例

## 环境配置

Dockerfile是一个用于构建Docker镜像的文本文件，包含了一系列的指令和参数。

```bash
mkdir Filename
cd Filename
vim Dockerfile
```

将以下复制到Dockerfile中

```dockerfile
FROM osrf/ros:humble-desktop-full
# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
${NVIDIA_VISIBLE_DEVICES:-all}

ENV NVIDIA_DRIVER_CAPABILITIES \
${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get update && \
apt-get install -y \
build-essential \
libgl1-mesa-dev \
libglew-dev \
libsdl2-dev \
libsdl2-image-dev \
libglm-dev \
libfreetype6-dev \
libglfw3-dev \
libglfw3 \
libglu1-mesa-dev \
freeglut3-dev \
vim
```

* FROM：指定镜像
* ENV：定义环境变量
* RUN：安装依赖 

接下来用以下命令构建容器

```bash
docker build -t rocker .
```

* rocker：想指定的容器名

如果不报错则可直接下一步；如果报错，可以删除RUN部分重新构建，可以后续进入容器按照以下命令安装

```bash
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
apt update
apt install vim 
```

## 运行容器

构建成功后，启动容器：

```bash
sudo xhost +local:
docker run -it --device=/dev/dri --group-add video --volume=/tmp/.X11-unix:/tmp/.X11-unix  --env="DISPLAY=$DISPLAY"  --name=rocker osrf/ros:humble-desktop-full  /bin/bash
```

* -it: 这是两个选项的组合，表示交互式运行容器，并在退出时删除容器。
* --device=/dev/dri: 将主机上的/dev/dri设备映射到容器内的设备上。这通常用于图形界面应用程序，如X11。
* --group-add video: 将用户添加到名为video的用户组中。这通常用于允许用户访问视频设备。
* --volume=/tmp/.X11-unix:/tmp/.X11-unix: 将主机上的/tmp/.X11-unix目录映射到容器内的相同目录。用于共享X11会话。
* --env="DISPLAY=$DISPLAY": 设置了环境变量DISPLAY，其值与主机上的$DISPLAY环境变量相同。这通常用于让容器内的应用程序能够访问主机上的图形界面。
* --name=rocker: 为新创建的容器指定一个名称rocker。

进入容器后会发现里面有一个名为ros_entrypoint.sh的*脚本，执行该脚本即可

```bash
root@3635c9ed27b3:/#  ./ros_entrypoint.sh
```

至此所有配置结束，想要多开终端进入容器可以

```bash
sudo docker ps	# 找到运行的当前容器的ID代入${CONTAINER ID}
sudo docker exec -it ${CONTAINER ID} /bin/bash
```

此种方法可以在本机访问docker中的图形化界面。



后记：此教程参考多篇博客，此处列出以示感谢

[1] [Docker 入门与实践](https://zhengyu.tech/archives/docker%E5%85%A5%E9%97%A8%E4%B8%8E%E5%AE%9E%E8%B7%B5)

[2] [Docker内运行ROS(melodic版本)以及使用Rviz](https://blog.csdn.net/qq_40695642/article/details/117607446)

[3] [Docker系列学习(二)——查看，启动，退出，保存镜像的方法](https://www.cnblogs.com/CircleWang/p/15154125.html)
