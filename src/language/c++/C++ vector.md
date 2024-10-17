# C++ vector

## 一.  概述

1.定义：可以改变大小的数组的，具有连续的存储空间

2.局限性：通过消耗更多的内存来换取动态调节的能力

## 二. 成员函数

首先要清晰的认识到迭代器是一个对象

```cpp
std::vector<int> myvector = {1, 2, 3, 4, 5};

// 返回指向容器第一个元素的迭代器
myvector.begin()
// 返回指向容器最后一个元素所在位置后一个位置的迭代器
myvector.end()
// 返回指向最后一个元素的迭代器
myvector.rbegin()
// 返回指向第一个元素所在位置前一个位置的迭代器
myvector.rend()
// 在原有基础上增加const属性，即不能修改元素
myvector.cbegin()
myvector.cend()
myvector.crbegin()
myvector.crend()
    
// 返回元素个数
size_type size() const noexcept;
// 返回元素个数最大值
size_type max_size() const noexcept;
// 改变实际元素的个数
void resize (size_type n);
void resize (size_type n, const value_type& val);
// 返回当前容量      容量不等同于元素个数
size_type capacity() const noexcept;
// 判断容器中是否有元素
bool empty() const noexcept;
// 增加容器的容量
void reserve (size_type n);
// 将内存减少到等于当前元素实际所使用的大小
void shrink_to_fit();

// 重载运算符[] 类似数组中元素访问方法
      reference operator[] (size_type n);
const_reference operator[] (size_type n) const;

// 返回对容器中位置n处元素的引用
      reference at (size_type n);
const_reference at (size_type n) const;

// 返回第一个元素的引用
      reference front();
const_reference front() const;

// 返回最后一个元素的引用
      reference back();
const_reference back() const;

// 返回指向容器中第一个元素的指针
      value_type* data() noexcept;
const value_type* data() const noexcept;

// 批量填入内容
template <class InputIterator>
void assign (InputIterator first, InputIterator last);

void assign (size_type n, const value_type& val);

void assign (initializer_list<value_type> il);

// 在容器的尾部添加一个元素
void push_back (const value_type& val);
void push_back (value_type&& val);

// 移除容器尾部的元素
void pop_back();

// 在指定的位置插入一个或多个元素
iterator insert (const_iterator position, const value_type& val);

iterator insert (const_iterator position, size_type n, const value_type& val);

template <class InputIterator>
iterator insert (const_iterator position, InputIterator first, InputIterator last);

iterator insert (const_iterator position, value_type&& val);

iterator insert (const_iterator position, initializer_list<value_type> il);

// 移出一个元素或一段元素
iterator erase (const_iterator position);
iterator erase (const_iterator first, const_iterator last);

// 交换两个容器的所有元素
void swap (vector& x);

// 移除所有元素，容器大小变为0
void clear() noexcept;

// 推荐使用如下，效率高
// 在指定位置直接生成一个元素
template <class... Args>
iterator emplace (const_iterator position, Args&&... args);

// 在容器尾部生成一个元素
template <class... Args>
void emplace_back (Args&&... args);
```



## 三. 迭代器

迭代器是一个对象！！！

看似拥有类似指针的性质，实则是通过重载运算符来完成的

```cpp
vector<int> ::iterator it;//读写
std::vector<int>::const_iterator it;//只读，不可以修改
```

