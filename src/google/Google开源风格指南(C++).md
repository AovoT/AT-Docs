# Google开源风格指南(C++)

## 1.头文件

一个.c文件对应一个.h头文件，应自给自足，避免导入其他文件

### #define防护符

所有头文件都应使用#define避免重复导入

格式:

```cpp
<项目>_<路径>_<文件名>_H_   //均大写
```

示例：

```cpp
//路径foo/src/bar/baz.h
#ifndef FOO_BAR_BAZ_H_  //是否被定义
#define FOO_BAR_BAZ_H_  //若没有定义则此处定义
...
#endif  // FOO_BAR_BAZ_H_
```

### 避免使用前向声明，应直接导入头文件

### #include导入的顺序

```cpp
//路径相对于项目源代码路径，其中不要使用 . 或者 ..
//引入google-awesome-project/src/base/logging.h头文件
//logging.h相对项目源码路径为base/logging.h
#include <base/logging.h>
```

```cpp
//顺序：配套的头文件, C 语言系统库头文件, C++ 标准库头文件, 其他库的头文件, 本项目的头文件.
//使用空格分开，同一分组按照首字母排序
//在armor_auto_aim.cpp中
#include <armor_auto_aim.h> //配套头文件

#include <math.h>  //C语言

#include <iostream>  //C++

#include <opencv2/opencv.hpp>  //第三方库

#include <serial_port/VCOMCOMM.h>  //本项目其他头文件
```

可以有条件的导入头文件，使用``#ifndef`` ``#define`` `` #endif``即可实现

## 2.作用域

### 2.1命名空间

```cpp
namespace outer {
inline namespace inner {
    void foo();
}  // namespace inner
}  // namespace outer
```

- 内联命名空间会自动把其中的标识符置入外层作用域，就是说在使用外部命名空间的时候，不需要显示的指定内部命名空间

- .h 和 .cc文件命名空间应一一对应

- 不要在 `std` 命名空间内声明任何东西.

- 禁止使用 *using 指令* 引入命名空间的所有符号

- ### 2.2内部链接


`.cc` 文件中所有不需要外部使用的代码采用内部链接. 不要在 `.h` 文件中使用内部链接，保证头文件简洁

内部链接：放入匿名命名空间或声明为 `static`

### 2.3非成员函数，静态成员函和全局函数

- 将非成员函数放入命名空间; 尽量不要使用完全全局的函数 .

- 不要仅仅为了给静态成员分组而使用类. 
- 类的静态方法应当和类的实例或静态数据紧密相关.

### 2.4局部变量

- 应该尽可能缩小函数变量的作用域 , 并在声明的同时初始化.

- 声明里第一次使用越近越好

- 特别注意，如果在循环内定义实例化对象，则每次都要调用构造和析构函数，所以尽量在循环外定义

- ## 7.命名约定


进行命名规范的必要性：

1.根据名称知道类型

2.方便团队开发

### **7.1通用命名规则**

总之，要用描述性，少用缩写，尽量用约定俗称的命名

### **7.2文件命名**

对文件后缀的规范：

​	C++中，.cc对应源文件  .h对应头文件  .inc对应专门插入文本的文件

定义类时，类的头文件和源文件要成对出现

```cpp
//文件名全部小写，可以包含下换线或连字符，下换线更好
color_detect.h
//对应源文件
color_detect.cpp
    
//内联函数定义要放在.h文件中，如果内联函数比较短，就直接将实现也放在 .h 中
```

### **7.3类型命名**

```cpp
//类型名的每个首字母均大写，不包含下换线，连着写
class CameraClass {
    ...
}
struct ChoosePoint {
    ...
}

//类型名指类，结构体，类型定义typedef,枚举，类型模版参数
```

### **7.4变量命名**

```cpp
//变量（包含函数参数）和数据成员名一律小写，单词之间用下划线连接
int apple_price;

class Person {
public:
    ...
public:
    int age_; //类的成员变量以下换线结尾
}

//结构体不用
struct Point { 
    int x;
    int y;
}
```

### **7.5常量命名**

```cpp
//常量命名以k开头，大小写混合
const kPi = 3.14;  //常量声明用constexpr或const修饰
```

### **7.6函数命名**

```cpp
void ChooseMax(int &num1, int &num2) { //首字母大写 大小写混合，取值和设值函数则要求与变量名匹配
    ...
}
void Set_price(float &price) {
    ...
}
```

### **7.7命名空间命名**

```cpp
namespace selfshoot; //使用小写，不要缩写
```

### **7.8枚举命名**

```cpp
enum LightColor {  //和常量一样:  以k开头，大小写混合 (建议)
    kRed,
    kBlue,
};
enum LightColor {  //和枚举一样：全部大写，用下划线连接
    BRD,
    BLUE,
};
```

### **7.9宏命名**

```CPP
#define VIDEO_ADDRESS /home/mzy/Videos/blue.mp4  //全部大写，下划线连接
```





