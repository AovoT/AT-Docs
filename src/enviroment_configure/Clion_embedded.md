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

**记住下载/安装路径(建议和CubeMx放一起，路径不能有空格，不然不能调试)**

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

### 3.1 stlink.cfg

```
# 设置调试器（建议用stlink或daplink，原因可参考4.3）
source [find interface/stlink.cfg]
#source [find interface/cmsis-dap.cfg]

# 调试接口（新版本会自动选择）
#transport select hla_swd

# 设置芯片（F4系列）
source [find target/stm32f4x.cfg] 
```

# 四. 其他问题

### 4.1 无法正确读取浮点数

在 `CMakeLists.txt` 中添加

```cmake
set(COMMON_FLAGS "-specs=nosys.specs -specs=nano.specs -u _printf_float -u _scanf_float")
```

### 4.2  `cubemx`生成后`cmake`无报错，构建时会出现`error：selected FPU does not support instruction`

在`CMakeLists.txt`中取消注释`Uncomment for hardware floating point`如下

```cmake
# Uncomment for hardware floating point
add_compile_definitions(ARM_MATH_CM4;ARM_MATH_MATRIX_CHECK;ARM_MATH_ROUNDING)
add_compile_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)
add_link_options(-mfloat-abi=hard -mfpu=fpv4-sp-d16)
```

### 4.3 运行 `LED_CLion.elf`时出错: `Cannot run program 

未配置`OpenOCcd`，在`运行/调试配置`中加入`OpenOCD 下载并运行`配置并添加面板配置文件`.cfg`

### 4.4 使用jlink下载程序出现错误No J-link device found

参考连接：[openOCD和Jlink仿真器_openocd找不到jlink_nepqiu的博客-CSDN博客](https://blog.csdn.net/K_O_R_K/article/details/120615059)



### 4.5 下载可以，但调试时出现`GDB Server stopped, exit code 1`无法调试

`OpenOCD`所在路径有空格存在，需换无空格目录并更改环境变量路径，（例如下方目录CLion 2023中间有空格）

```
调试时出现：
Unexpected command line argument:CLion 2023.2.2\OpenOCD-20231002-0.12.0\share\openocd		  
\scripts
GDB Server stopped, exit code 1
```

