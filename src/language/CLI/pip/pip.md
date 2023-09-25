> pip python包管理工具

# 一. cmd

```shell
pip index versions [:packageName:]  # 查看包的所有版本
pip install [:packageName:]==[:version:]  # 下载指定版本
pip install --upgrade [:packageName:]  # 更新指定包
pip show [:packageName:]  # 查看指定包的信息  (版本)
pip list # 查看已安装的所有包

pip config list  # 查看当前pip源
```

# 二. 换源

## 1. 源

阿里云				 	 http://mirrors.aliyun.com/pypi/simple/

中国科技大学 	 	 https://pypi.mirrors.ustc.edu.cn/simple/

豆瓣(douban)	 	  http://pypi.douban.com/simple/

清华大学                  https://pypi.tuna.tsinghua.edu.cn/simple/

中国科学技术大学    http://pypi.mirrors.ustc.edu.cn/simple/

## 2. 临时

```shell
pip install numpy -i  https://pypi.tuna.tsinghua.edu.cn/simple
```

## 3. 永久

### 3.1 Linux系统

在当前用户目录创建.pip隐藏目录
将软件源地址写入 .pip/pip.conf  文件（无论是pip还是pip3，方法一致。）

```
sudo apt install -y vim
mkdir -p ~/.pip/
vim ~/.pip/pip.conf
```

   .pip/pip.conf   的文件内容如下

```
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
```

### 3.2 Windows系统

在当前用户目录下创建pip目录，即C:\Users\xxx\pip\ (xxx指代用户名)
在pip目录下创建pip.ini文件，文件内容如下

```bash
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn  # https://【pypi.tuna.tsinghua.edu.cn】/simple
```

