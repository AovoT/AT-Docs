# 1. 语法

注释  #

foo.txt   # 忽略所有文件名为 foo.txt

*.html     # 忽略所有文件后缀为.html文件

!test.html   #  不忽略test.html文件

*.[ab]      # 忽略所有 *.a  和 *.b 的文件

dir/    # 只忽略 dir/ 目录, 不忽略dir文件

dir     # 只忽略 dir/ 文件, 不忽略dir目录

/ttt    #  只忽略当前目录下的ttt文件和目录，子目录的ttt不在忽略范围内

# 2. 上传

## 2.1 全局

### 2.1.1 编辑  `.gitconfig`  文件

```
[gui]
    encoding = utf-8
[core]
   excludesfile = ~/.gitignore
```

### 2.1.2 命令行

```
git config --global core.excludefile ~/.gitignore
```

二者选择任意一个

## 2.2 单个( 远程仓库共用 )

单个仓库下忽略，同时同步该设置至远程仓库，与其他克隆仓库共用
配置方法:
	仓库的根目录下建 `.gitignore` 文件，同时把 `.gitignore` 文件加入版本管理。

## 2.3 单个( 本机 )

本机当前仓库起效，不会对其他的克隆仓库起效
配置方法:
编辑仓库根目录下的`.git/info/exclude`文件, 

## 2.4 已跟踪文件的改动

```
#忽略跟踪(提交代码时，忽略某一个文件不提交，即某个文件不被版本控制)
git update-index --assume-unchanged FLIE   #FILE是目标文件路径       
#恢复跟踪
git update-index --no-assume-unchanged FLIE   #FILE是目标文件路径  
```

不过如果执行 `git checkout`和`git reset`的时候仍然会影响到这些文件，并把内容恢复到被跟踪的内容（再次修改仍然不会被跟踪）。

如果忽略的文件多了，可以使用以下命令查看忽略列表

```
git uls-files -v | grep '^h\ '
```

提取文件路径，方法如下

```
git ls-files -v | grep '^h\ ' | awk '{print $2}'
```

所有被忽略的文件，取消忽略的方法，如下

```
git ls-files -v | grep '^h' | awk '{print $2}' |xargs git update-index --no-assume-unchanged  
```