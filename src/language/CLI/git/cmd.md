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
一般分为:
master
develop
feature
(hot fix)

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

# 五. 其他(关于一些错误信息的解决)

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

   

