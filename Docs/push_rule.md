<h1> <center> 关于 push 文档规则说明 </center> </h1>

# 一. 规则

- 每次需要修改仓库时都需要 `pull`, 保证本地与远程仓库一致
- 每次合并到主分支时都需要提交 `pull requests`
- 对于每个文档的开头都需要写明文档的大致内容 或 文档介绍的库的功能的概述
- 对于每个具体的文档, 应该都尽量分成小节表明点
  - 如: 一. 规则 1.1. pull requests 说明 

# 二. `pull requests`说明

## 2.1. 新分支

### 终端操作

```shell
git checkout -b 新分支名称

# 对文件进行具体体修改

git add 文件名
git commit -m "注释"
git push -u origin 新的分支的名称
```

### web操作

之后转到 `github` 页面, 点击 `Pull requests` -> `New pull requests` -> 将右侧 `compare`: 改成新创建的分支 -> 点击 `Create pull request`