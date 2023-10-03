> C++11/14/17/20 新特性
>
> 参考链接: https://changkun.de/modern-cpp/zh-cn/00-preface/

# 一. 语言可用性

## constexpr

```c++
constexpr int len1 = 4;
auto arr[len1] = {1, 2, 3, 4};
```

## if

```c++
// 将临时变量放到 if 语句内
if (const std::vector<int>::iterator itr = std::find(vec.begin(), vec.end(), 3);
    itr != vec.end()) {
    *itr = 4;
}

// constexpr
template<typename T>
auto print_type_info(const T& t) {
    if constexpr (std::is_integral<T>::value) {
        return t + 1;
    } else {
        return t + 0.001;
    }
}
// 在编译时就会确定
```

## std::initializer_list

```c++
MyClass(std::initializer_list<int> list) {
    for (std::initializer_list<int>::iterator it = list.begin();
         it != list.end(); 
         ++it)
        vec.push_back(*it);
}
```

## 多返回值

此特性会造成返回值不明确, 如果不写文档, 无法知道返回值具体是用来做什么的, 除非返回值明确(如: 返回 x, y, z)或配合结构体等尽量不使用

```c++
#include <iostream>
#include <tuple>

std::tuple<int, double, std::string> f() {
    return std::make_tuple(1, 2.3, "456");
}

int main() {
    auto [x, y, z] = f();
    std::cout << x << ", " << y << ", " << z << std::endl;
    return 0;
}
```

## 判断类型相同

```c++
std::is_same(decltype(x), int)::value
```

## using

```c++
using NewProcess = int(*)(void *);  /// 函数指针

template<typename T>
using TrueDarkMagic = MagicType<std::vector<T>, std::string>;  // 模板函数
```

## 右值 & 引用

| 函数形参类型 | 实参参数类型 | 推导后函数形参类型 |
| :----------: | :----------: | :----------------: |
|      T&      |    左引用    |         T&         |
|      T&      |    右引用    |         T&         |
|     T&&      |    左引用    |         T&         |
|     T&&      |    右引用    |        T&&         |

- 右值

  - 纯右值: 纯字面量(不包括字符串字面量, 其为 const char* )、匿名临时对象

  - 将亡值: 

    - ```c++
      std::vector<int> foo() {
          std::vector<int> temp = {1, 2, 3, 4};
          return temp;
      }
      ```

```c++
// 右值引用还是一个左值
std::string str = "asdad";
std::string&& str_ = str;
```

完美转发

```c++
void reference(int& v);
void reference(int&& v);

template <typename T>
void pass(T&& v) {
    // T&& 为左值
    reference(v);  // 调用 reference(int&)
    
    reference(std::forward<T>(v));  // 调用reference(int&&);
}

pass(1);  // 传入右值
```

# 二. 并行与并发

## std::function

可调用对象

```c++
std::function<int(int, int)> task;
```

## std::bind

创建可调用对象

```c++
/// 普通函数
void testFunc(int a, int b) {
    // do ...
}
auto func = std::bind(testFunc, 1, std::placeholders::_1);  // 创建可调用对象


/// 类函数
class MyClass {
public:
    void classFunc(int a, int b) {
        // do ...
    }
}

MyClass obj;
auto class_func = std::bind(&MyClass::classFunc, &obj, 5, std::placeholders::_1);  // 创建可调用对象
```

## std::result_of

获取函数调用的返回类型, 不执行实际的调用

```c++
template <typename Function, typename... Args>
using return_type = typename std::result_of<Function(Args...)>::type;
```

## std::forward

在泛型编程中进行完美转发(perfect forwarding)

```c++
// example 1
template <typename T>
void Func(T&& val) {
    ???(std::forward<T>(val));
}
// example 2
template<typename Function, typename Args>
auto ThreadPool::enqueue(Function&& func, Args... args)
	-> std::future<typename std::result_of<Function(Args...)>::type>
{
    using return_type = typename std::result_of<Function(Args...)>::type;
    auto task = std::make_shared<std:::packaged_task<return_type()>>(
    	std::bind(std::forward<Function>(func), std::forward<Args>(args)...)
    );
}
```

## std::packaged_task

将 *函数或可调用对象* 封装为可异步执行的任务

```c++
int add(int a, int b);

std::packaged_task<int(int, int)> task(add);

std::future<int> result = task.get_future();  // 获取与 packaged_task 关联的 future
```

## std::future

管理和获取异步任务的返回值或异常

```c++
std::future<int> results;
```

