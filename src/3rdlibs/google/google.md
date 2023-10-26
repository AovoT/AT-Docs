## 一. GFlags

> 从命令行获取参数(可以与GLog协同)

```shell
# 如果没有 Ninja
# sudo apt install -y ninja-build

cd /tmp && \
git clone https://github.com/gflags/gflags.git --depth=1 && \
cd gflags && \
cmake -B build -G "Ninja" -DBUILD_SHARED_LIBS=ON && cmake --build build && sudo cmake --build build --target install
```

```cmake
find_package(gflags REQUIRED)
target_link_libraries(${PROJECT_NAME gflags)
```

## 二. Glog

> google的日志库

```shell
cd /tmp && \
git clone https://github.com/google/glog.git --depth=1 && \
cd glog && \
cmake -B build -G "Ninja" && cmake --build build && sudo cmake --build build --target install
```

```cmake
find_package(glog REQUIRED)
target_link_libraries(${PROJECT_NAME glog::glog)
```

## 三. GTest

> google测试框架

### 3.1 不编译安装
不用在本地编译安装，CMake在构建时会自动下载(可能需要代理)
```cmake
include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest/
  GIT_TAG v1.14.0
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)
```
### 3.2 本地编译安装
```shell
cd /tmp && \
git clone https://github.com/google/googletest.git --depth=1 && \
cd googletest && \
cmake -B build -G "Ninja" && cmake --build build && sudo cmake --build build --target install
```

```cmake
find_package(GTest REQUIRED)
target_link_libraries(${PROJECT_NAME} 
        GTest::gtest
        GTest::gtest_main
        GTest::gmock
        GTest::gmock_main
        )
```
