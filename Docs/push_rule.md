<h1> <center> 关于 push 文档规则说明 </center> </h1>

# 一. 规则

- 每次需要修改仓库时都需要 `pull`, 保证本地与远程仓库一致
- 每次合并到主分支时都需要提交 `pull requests` (合并请求)
- 对于每个文档的开头都需要写明文档的大致内容 或 文档介绍的库的功能的概述(或使用引用语法 或使用 大标题等 写在整个文档的开头)
- 对于每个具体的文档, 应该都尽量分成小节表明点
  - 如: 一. 规则 1.1. pull requests 说明 
- `img` 存放 `src` 中对应文档所需要的资源(目录结构要一致)

# 二. `pull requests`说明

有创建新分支->并入主分支，fork后两次提交到新分支两种方法

## 2.1. 新分支

### 终端操作

```shell
git checkout -b 新分支名称

# 对文件进行具体体修改

git add 文件名
git commit -m "注释"
git push -u origin 新的分支的名称
```

### Web操作

之后转到 `github` 页面, 点击 `Pull requests` -> `New pull requests` -> 将右侧 `compare`: 改成新创建的分支 -> 点击 `Create pull request`

## 2.2. Fork

### Web操作

在本仓库主页，点击右上角`Fork`拉取到自己的仓库

### 终端操作

```shell
git clone Fork后的仓库链接

# 对文件进行具体体修改

git add .
git commit -m "注释"
git push -u origin master(主分支名称)
```

### Web操作

转到自己fork的仓库，刷新后显示

> This branch is [(num) commits ahead](https://github.com/NobleFlower/AT-Docs/compare/AovoT:AT-Docs:master...master) of AovoT:master.

点击本条目右边`Contribute`->`Open pull requests`，接下来无需修改，点击`Create pull request`