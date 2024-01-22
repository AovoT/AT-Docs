# 一. 一些变量

## 1. $(nproc)

CPU核心数

# 二. 打开

## 1. 打开文件管理器

```
nautilus
```

## 2. 打开默认图片管理器

```shell
Xdg-open <filename>
```

## 3. 打开PDF文件

```shell
evince <filename>
```

# 三. 指令系列

## 1. xargs

用于将输出结果作为 参数 传递给另一个命令

```shell
cd /usr/include;find . -name "*.h" | xargs grep "IPPROTO_TCP"
```

## 2. chown

```shell
 chown [-R] 所有者 文件或目录
```

## 3. find

`find` 命令的语法如下：

```shell
find [path] [expression]
```

其中，`path` 是指定搜索的目录，`expression` 是指定搜索的表达式，可以是文件名、文件类型、文件大小、文件权限等属性。

常用的 `find` 命令选项及表达式如下：

- `-name`：按照文件名进行搜索，支持通配符。
- `-type`：按照文件类型进行搜索，如文件（`f`）、目录（`d`）、链接文件（`l`）等。
- `-size`：按照文件大小进行搜索，支持用 `+` 和 `-` 表示大于或小于指定大小。
- `-perm`：按照文件权限进行搜索，如 644、777 等。
- `-mtime`：按照文件修改时间进行搜索，支持用 `+` 和 `-` 表示在指定时间前或后修改过的文件。
- `-exec command {} \`: `command` 表示要执行的命令,`{}` 表示当前搜索到的文件名(包含完整路径),`\;` 表示命令执行结束。

以下是一些示例：

- 搜索文件名为 `file.txt` 的文件：`find /path/to/search -name file.txt`
- 搜索所有的目录：`find /path/to/search -type d`
- 搜索大于 1MB 的文件：`find /path/to/search -size +1M`
- 搜索修改时间在 7 天以内的文件：`find /path/to/search -mtime -7`
- `find / -type f -name "python*"`

`find` 命令可以与其他命令进行组合使用，例如可以使用 `exec` 执行搜索到的文件：

```shell
find /path/to/search -name "*.txt" -exec cat {} \;
```

上述命令可以搜索所有扩展名为 `.txt` 的文件，并将其内容输出到终端。

## 4. systemctl

```shell
sudo systemctl start myservice.service # 启动服务
sudo systemctl stop myservice.service  # 停止
sudo systemctl restart myservice.service  # 重启
sudo systemctl reload myservice.service  # 重新加载
sudo systemctl enable myservice.service  # 设置开机启动
sudo systemctl disable myservice.service  # 取消开机启动
sudo systemctl status myservice.service  # 查看状态
```

## 5. lsb_release 显示当前Linux发行版

用于显示当前Linux发行版的信息，包括发行版名称、版本号和发行日期等信息。可以在终端中输入以下命令查看当前系统的LSB版本:

```shell
lsb_release -a

```

```shell
sudo apt install -y screenfetch
screenfetch
```

## 6. locale 设置本地化信息

```
Linux 系统中用来设置本地化信息的命令。
用于显示或修改当前 Linux 系统的本地化设置。

查看当前系统的本地化设置信息，包括语言、编码、货币符号、日期时间格式等等。

LANG: 默认编码
LC_ALL: 覆盖所有其他环境变量的值
LC_CTYPE: 字符类型 (字符分类)
LC_NUMERIC: 数字格式
LC_TIME: 日期和时间格式
LC_COLLATE: 字符排序
LC_MONETARY: 货币格式
LC_MESSAGES: 消息输出 (通常是翻译)
```

## 7. ss 查看socket统计信息

查看socket统计信息的命令，以下是一些常用的ss命令

1. ss -t：显示所有TCP socket。
2. ss -u：显示所有UDP socket。
3. ss -a：显示所有socket，包括TCP、UDP和RAW类型。
4. ss -p：显示每个socket所属的进程。
5. ss -l：显示所有监听socket。
6. ss -o：显示socket定时器信息。
7. ss -n：以数字格式显示IP和端口。
8. ss -H：显示TCP和UDP socket的带宽使用情况。
9. ss -i：显示网络接口信息和统计数据。
10. ss -r：显示路由表信息。
11. ss -s：显示socket的统计信息。

## 8. zenity || notify-send 弹出消息框

```shell
zenity --info --text "OpenCV代理替换脚本"
```

```css
notify-send [OPTIONS] <SUMMARY> [BODY]
-u, --urgency <LEVEL>: 设置通知的紧急级别，可选值为 "low"、"normal" 和 "critical"
-t, --expire-time <TIME>: 设置通知的显示时间（毫秒），在指定时间后通知会自动消失
-i, --icon <ICON_PATH>: 设置通知的图标
-c, --category <CATEGORY>: 设置通知的类别
-a, --app-name <APP_NAME>: 设置通知的应用程序名称
-h, --hint <HINT>:<VALUE>: 设置通知的其他提示信息
notify-send -h string:x-canonical-private-synchronous:foo "Hint Notification" "This notification has a custom hint."
```

## 9. 定时任务

```shell
crontab -e  # 编辑定时任务
#每个要运行的任务都必须通过一行定义

# minute (m), hour(h), day of month (dom), month (mon),and day of week (dow)
# m h dom mon dow  用“*”（表示“any”）
#
#请注意，任务将基于cron的系统启动守护进程的时间和时区概念。
#crontab作业的输出（包括错误）通过发送向crontab文件所属的用户发送电子邮件（除非重定向）

# 查看定时任务日志
grep CRON /var/log/syslog
```



## 10.解压系列

### 10.0 解压

```shell
#.tar.gz
解压: tar -xzvf filename.tar.gz
压缩: tar -czvf demo.tar.gz demo.c

# .tar.xz
解压: tar -xf archive.tar.xz

# .gz
解压: gzip -dv filename
压缩: gzip filename
gzip -c demo.c>demo.c.gz
#使用-c选项，但是不让压缩数据输出到屏幕上，而是重定向到压缩文件中，这样可以缩文件的同时不删除源文件

#.zip
解压: unzip Test.zip -d ~/HOME/
压缩: zip -r Test.zip Test.txt Public/
```



### 10.1 tar

```shell
-c：创建新的归档文件。
-x：提取归档文件中的文件。
-f <file>：指定归档文件的名称。
-v：显示详细的操作过程，即显示正在处理的文件列表。
-z：使用gzip进行压缩或解压缩。
-j：使用bzip2进行压缩或解压缩。
-r：向归档文件中添加新文件。
-t：列出归档文件中的文件列表。
-u：只提取较新的文件。
-p：保留文件的原始权限和属性。
-C <directory>：在指定目录中执行操作。
--exclude=<pattern>：排除与指定模式匹配的文件或目录。
--exclude-from=<file>：从文件中读取要排除的模式列表。
--wildcards：使用通配符模式匹配文件和目录。
--strip-components=<number>：从文件名中去除指定数量的路径组件。
```

## 11. 查看ip地址

```shell
ip addr show
ip a

curl ifconfig.me
hostname -I
```

## 12. 查看系统信息

### 查看系统信息

```shell
uname -a  # 显示内核信息，包括内核版本、系统架构等。
lsb_release -a  # 显示Linux发行版信息，包括发行版名称、版本等。
cat /etc/os-release  # 查看操作系统的信息，包括发行版名称、版本、ID等。
```

### 查看系统硬件信息

```shell
lscpu  # 显示CPU信息，包括处理器型号、核心数、线程数等。
lsblk  # 显示块设备信息，包括磁盘分区、大小等。
lshw  # 显示硬件信息，包括CPU、内存、显卡、网络适配器等。
```


### 查看内存和磁盘信息

```shell
free  # 显示内存使用情况，包括已用、可用、缓存等。
df -hT  # 显示磁盘使用情况，包括磁盘空间、已用、可用等。
```

### 查看网络信息

```shell
ifconfig: 显示网络接口信息，包括IP地址、MAC地址等。（在较新的Linux发行版中，已经被ifconfig取代）
ip addr: 显示网络接口信息，包括IP地址、MAC地址等。（新版本的替代命令）
netstat -tuln: 显示网络连接信息，包括监听的端口等。
```

### 查看进程信息：

```shell
ps aux: 显示所有正在运行的进程信息，包括进程ID、CPU使用率等。
top: 动态实时显示系统进程信息，按CPU使用率排序。
```

## 13. tree

```shell
echo "" | sudo tee /etc/apt/sources.list
```

## 14. 用户管理

### 14.1 创建新用户

```shell
useradd -d /home/new_user -m sam -s /bin/bash -g new_user_group -G adm,root -c "注释"
passwd new_user

chown -R new_user:new_user /home/new_user
```

### 14.2 用户具有 sudo 权限

```shell
sudo visudo

new_user ALL=(ALL:ALL) ALL
```

### 14.3 新用户加入sudo adm组

```shell
sudo usermod -aG sudo new_user
sudo usermod -aG adm new_user
```



# 四. 执行.exe文件

```sh
# 安装wine
sudo add-apt-repository ppa:ubuntu-wine/ppa
sudo apt-get update
sudo apt-get install wine
```

# 五. 对于动态链接库的探讨

`LIBRARY_PATH`环境变量用于在***程序编译期间***查找动态链接库时指定查找共享库的路径。

`LD_LIBRARY_PATH`环境变量用于在***程序加载运行期间***查找动态链接库时指定除了系统默认路径之外的其他路径。



共享库的寻找和加载是由 /lib/ld.so 实现的。 ld.so 在标准路经(/lib, /usr/lib) 中寻找应用程序用到的共享库。

将非标准路经加入 /etc/ld.so.conf，然后运行 ldconfig 生成 /etc/ld.so.cache。 ld.so 加载共享库的时候，会从 ld.so.cache 查找。

还有一个环境变量：LD_LIBRARY_PATH 来处理非标准路经的共享库。ld.so 加载共享库的时候，也会查找这个变量所设置的路经。

```sh
ldconfig -v -N  # 列出系统在寻找库时的所有路径
```

```sh
vim ld.so.conf  # 文件

cd /etc/ld.so.conf.d  # 路径
sudo vim new_file.conf
```

