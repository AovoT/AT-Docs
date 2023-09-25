# 更新conda至最新版本

```
conda update conda
```


# 创建python环境

```
conda create --name py2 python=2.7  
conda create --name py3 python=3.8
```

# 激活环境

```
win: activate py2
macOS、Linux: conda activate py2
```

# 停用环境

```
windows: deactivate
macOS、Linux: conda deactivate
```

# 切换环境

```
source activate <env_name>
```

# 显示已创建环境

```
conda info --envs
或
conda info -e
或
conda env list
```

# 复制环境

```
conda create --name <new_env_name> --clone <copied_env_name>
```

# 删除环境

```
conda remove --name <env_name> --all
```

# 查找可供安装的包版本

```
精确查找
conda search --full-name <package_full_name全名>
粗略查找
conda search <text>  # 只要包名包含此字段
```

# 获取当前环境中已安装的包信息

```
conda list
```

# 源管理

```shell
# 查看已有源
conda config --show-sources
# conda 配置信息文件--略过

# 删除并恢复默认的conda源
conda config --remove-key channels 

# 设置安装包时，显示镜像来源，建议显示
conda config --set show_channel_urls yes

# 添加源
conda config --add channels <....> https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/

# 删除指定源
conda config --remove channels <....>
```

# 安装包

```shell
# 在指定环境中安装包
conda install --name <env_name> <package_name>
<env_name> 环境名
# 当前环境中安装包
conda install <package_name>
conda install --yes <package_name>=<version>  # 直接确认安装

conda install --dry-run <package_name>  # 假执行
```

# 卸载包

```
卸载指定环境中的包
conda remove --name <env_name> <package_name>
卸载当前环境中的包
conda remove <package_name>
```

# 更新包

```
更新所有包
conda update --all 或 conda upgrade --all
更新指定包
conda update <package_name> 或 conda upgrade <package_name>
```

# 搜索包

```
conda search
```

# 查看包占用的磁盘空间大小

```sh
du -sh <env path>
```