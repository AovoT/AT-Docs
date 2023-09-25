> 参考链接: https://en.cppreference.com/w/cpp/chrono

# 一. API

## std::chrono::system_clock

```c++
#include <chrono

static std::chrono::time_point<std::chrono::system_clock> now() noexcept;
static std::time_t to_time_t( const time_point& t ) noexcept;
static std::chrono::system_clock::time_point from_time_t( std::time_t t ) noexcept;

const auto now = std::chrono::system_clock::now();
const std::time_t t_c = std::chrono::system_clock::to_time_t(now);
std::cout << std::ctime(&t_c) << endl;
<< 13:28:27 2023
```



## std::chrono::steady_clock

```c++
static std::chrono::time_point<std::chrono::steady_clock> now() noexcept;
```

```c++
// 时间间隔
auto start = std::chrono::steady_clock::now();
auto end = std::chrono::steady_clock::now();
std::chrono::duration<double> diff= = end - start;
cout << "diff: " << diff.count() << endl;
```

