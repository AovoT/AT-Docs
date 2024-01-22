## 锁

#### 读写锁

```c++
std::shared_lock<std::shared_mutex>;  // 共享锁 -- 写锁
std::unique_lock<std::shared_mutex>; std::lock_guard<std::shared_mutex>;  // 排他锁 -- 读锁
```

