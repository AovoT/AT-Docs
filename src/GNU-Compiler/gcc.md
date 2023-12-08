# GCC

```shell
gcc -E hello.c > output.txt  # 只预处理
gcc -S hello.c  # 只预处理、编译
gcc -c hello.c  # 预处理、编译、汇编  -> .obj文件
gcc -o main.c func.c -o app.out
gcc -Dmacro  # #define macro
gcc -Dmacro=aaa  # #define macro=aaa
gcc -Umacro # #undef macro
gcc -undef  # 取消任何非标准宏定义
gcc main.c -o main.out -I/usr/include;/home/user/include  # -I 添加头文件目录
gcc main.c -o main.out -L/usr/lib;/home/user/lib -L /home/user_1/lib  -lLibName # -L 添加链接库搜索路径 -l 指定库名字 (静态/动态库都可以)
g++ -std=c++17 main.cpp -o app.out
gcc -ggdb
gcc -static # 禁止使用动态库
gcc -share # 尽量使用动态库
gcc -O0 # 禁止优化
gcc -O4 # 优化等级为4
```

