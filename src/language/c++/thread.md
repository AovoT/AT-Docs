## 锁

#### 读写锁

```c++
// 共享锁 -- 读锁
std::shared_lock<std::shared_mutex>;
// 排他锁 -- 写锁
std::unique_lock<std::shared_mutex>; 
std::lock_guard<std::shared_mutex>;  
```

