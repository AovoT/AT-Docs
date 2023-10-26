# 一. 基本命令

```bash
git init  # 初始化
git add [:filename]  # 添加任务文件到暂存区
git commit -m “[::]”  # 提交暂存区文件到本地仓库

git push <远程主机名> <本地分支名>:<远程分支名>  # 推送到远程服务器  
git push <远程主机名> <本地分支名>  # 如果本地分支名与远程分支名相同，则可以省略冒号：

git branch “new branch”  # 创建新分支
git checkout “new branch”  # 切换分支
git branch -d “new branch”  # 删除分支
git remote add [shortname] [url]  # 添加远程版本库
```

# 二. 一般流程 

初始化 -> 添加任务文件到暂存区 -> 提交暂存区文件到本地仓库 -> (创建分支) -> 添加远程版本库 -> 提交到远程仓库

```bash
git init  # 初始化
git add . # 添加任务文件到暂存区
git commit -m "注释"  # 提交暂存区文件到本地仓库
git branch "new branch"  # 创建分支
git remote add origin https://github.com/...... # 添加远程版本库
git push -u origin main # 推送到远程服务器
```

# 三. 分支

```bash
git branch  # 列出分支
>>> (输出)
* master
↑ 有 * 表示当前分支为 master

git branch [new branch name]  # 创建新分支
git checkout [branch name]  # 切换分支
git merge  # 合并分支
git branch -d [branch name]  # 删除分支
git push origin -d [branch name]  # 删除远程仓库分支
# 分支冲突 .... 
```

git 分支介绍:
一般有:

- master
- develop
- fix-xxx

# 四. 远程仓库相关

```bash
git remote -v  # 显示所有远程仓库
git remote show [remote]  # 显示某个远程仓库信
git remote add [shortname] [url]  # 添加远程版本库
git remote rm name  # 删除远程仓库
git remote rename [old_name] [new_name]  # 修改仓库名

git push <远程主机名> <本地分支名>:<远程分支名>  # 推送到远程服务器  
git push <远程主机名> <本地分支名>  # 如果本地分支名与远程分支名相同，则可以省略冒号：
git push origin -d [branch name]  # 删除远程仓库分支
```

# 五. git 时光机(撤销)

> 参考视频链接: https://www.bilibili.com/video/BV1ne4y1S7S9/

首先明确 `git` 四个区域

- Disk (磁盘) 修改文件之后
- Staging (暂存区) git add 之后进入
- Local (本地仓库) git commit 之后进入
- Remote (远程仓库) git push 之后进入

***文件*** ------修改------->  ***Disk(changed)***  ----`git add`--->  ***Staging***  ----`commit`----> ***Local*** ----`push`----> ***Remote***

## 5.1 Disk中撤销

### 5.1.1 在文件进入 `Disk`之后撤销对文件的修改

```shell
git checkout <changed_filename> # old
# OR
git restore <changed_filename>  # new version
```

## 5.2 Staging 中撤销

从 Staging 移除, 保留 Disk 中的修改

```shell
git reset <changed_filename>
# OR
git restore --staged <changed_filename>
```

从Staging、Disk中移除

```shell
git checkout HEAD <changed_file>  # HEAD 表示最近的一次 commit
```

# 5.3 Local 中撤销

只撤销 `commit`(即从Local中移除)

```shell
git reset --soft HEAD~1  # HEAD~1 表示之前一个
```

同时撤销 `commit` 和 `add`(保留磁盘中的修改)

```shell
git reset HEAD~1
# OR
git reset --mixed HEAD~1
```

同时撤销 `commit` 和 `add` 和 磁盘中的修改

```shell
git reset --hard HEAD~1
```

***另外一种撤销方式***

```shell
git revert HEAD  # 一个 OR 多个 commit
```

`git revert` 会把撤销之后的结果单独创建一个 `commit` (即撤销之后, 把撤销之后仓库的状态 `commit`, 创建一个新的 `-change commit`)

## 5.4 Remote 中撤销

如果是 **公有分支** 那么必须使用 `git revert`

非共有分支(个人分支)可以使用 `git reset`, 然后使用 `git push -f` 提交

# 其他(关于一些错误信息的解决)

在第一次提交后，之后的提交提示

```
Everything up-to-date
branch 'branch' set up to track 'origin/branch'.
```

可以尝试一下 三种方法之一 (是按简单程度，没有按使用效果排)，或者直接看这个博客

https://blog.csdn.net/boysky0015/article/details/78160825  (这个就是第三种方法)

1. 先切换到该分支再提交

2. 强制提交

   ```
   git push -u origin [branch name] -f
   ```

   这种没有试过

3. 创建新分支 提交到新创建的分支 合并两个分支(这种应该可以)

   ```bash
   # 创建新分支
   git branch dev # 创建一个dev分支  dev是分支的名字 可以随便命名
   
   # 添加到暂存区
   git add .
   
   # 提交到版本库，也就是当前分支
   git commit -m "注释"
   
   # 提交到远程仓库
   git push origin dev
   
   # 切换到mater分支
   git checkout master
   
   # 把dev分支合并到maste上
   git merge dev
   
   # 最后提交到远程仓
   git push -u origin master
   
   # 可以选择是否删除之前创建的新分支
   git push origin -d dev  # 删除远程仓库分支
   ```

   

   ```shell
   git filter-branch --msg-filter \
   'if [ "$GIT_COMMIT" = "PARENT_COMMIT_HASH" ]; \
   then \
   echo "New commit message for parent directory"; \
   else cat;\
   fi' --subdirectory-filter subdirectory HEAD
   ```

# 六、git仓库体积精简

## 6.1 查看仓库体积

   ```bash
   git count-objects -vH
   ```

## 6.2 查找大文件

   可查看占用空间最大的前15个文件，`head -15`中的数字即为显示数量
   
   ```bash
   git rev-list --all | xargs -rL1 git ls-tree -r --long | sort -uk3 | sort -rnk4 | head -15
   ```
   
## 6.3 遍历提交记录并删除大文件对象

   **注意：** 本地仓库不能有修改

   ```bash
   git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch 文件相对于终端的路径' --prune-empty --tag-name-filter cat -- --all
   # 若要删除整个文件夹，则把路径改为文件夹目录，并加上 -r
   git filter-branch --force --index-filter 'git rm --cached -r --ignore-unmatch 文件夹相对于终端的路径' --prune-empty --tag-name-filter cat -- --all
   ```
   
## 6.4 本地仓库回收空间

   
   ```bash
   # 删除本地仓库引用
   rm -rf .git/refs/original/
   # 设置所有reflog条目现在过期
   git reflog expire --expire=now --all
   # 回收空间，移除无效或异常的文件
   git gc --aggressive --prune=now
   ```

   可再查看仓库体积进行对比
   
## 6.5 强制推送至远端

    ```bash
    git push origin --force --all
    ```
    



