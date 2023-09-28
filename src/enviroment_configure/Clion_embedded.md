> 使用Clion进行嵌入式开发

> 参考链接: https://zhuanlan.zhihu.com/p/145801160


# 一. 环境所需工具

### windows

- STM32CubeMX

- Clion

- MinGW

- OpenOCD

- arm-none-eabi-gcc

### Linux

- STM32CubeMX

- Clion

- OpenOCD

- arm-none-eabi-gcc

# 二. 安装

## 2.1. STM32CubeMX

Download: https://www.st.com/en/development-tools/stm32cubemx.html#get-software

~~(需要注册账号)~~

### Linux

```shell
unzip xxx.zip   # xxx为下载的文件名
cd xxx
chmod 777 SetupSTM32CubeMX-xxxx  # 加权限
./SetupSTM32CubeMX-XXX  # 安装

# 启动: 运行安装目录下的可执行文件
```

## 2. Clion

Download: https://www.jetbrains.com/clion/

## 3. MinGW(Windons)

### 2.3.1. 下载

Download: https://osdn.net/projects/mingw/releases/ 

### 2.3.2 环境变量

下载好后将 `xxx/bin` 添加到环境变量

### 2.3.3. Clion配置

Setting -> Build, Execution, Deployment -> Toolchains

## 4. OpenOCD

### 2.4.1. 下载

Windows: https://gnutoolchains.com/arm-eabi/openocd/

**记住下载/安装路径(WIndows)**

Linux: 

```shell
sudo apt install -y openocd
```

### 2.4.2 Clion配置

## 5. arm-none-eabi-gcc

Download: https://developer.arm.com/downloads/-/gnu-rm

### Linux

```shell
tar -xvjf ../gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2  # 解压
echo "export PATH=???/bin${PATH:+:${PATH}}" >> ~/.bashrc  # ???? 为安装路径
```

# 三. 文件模板

### 3.1 .cfg

```
interface jlink  # 调试器
transport select swd  # 接口
source [find target/stm32f1x.cfg]  # 具体的芯片名(此处示例使用STM32F103C8T6)

# download speed = 10MHz (👇没试过)
adapter speed 10000
```

# 五. 其他问题

5.1 无法正确读取浮点数

在 `CMakeLists.txt` 中添加

```cmake
set(COMMON_FLAGS "-specs=nosys.specs -specs=nano.specs -u _printf_float -u _scanf_float")
```

