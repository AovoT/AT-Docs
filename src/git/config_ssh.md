```sh
# 生成 SSH Key
ssh-keygen -t rsa -C "user1@email.com"

# 在运行完命令后会在 ~/.ssh(用户目录) 目录下创建以下两个文件
# windows 下为 `C:\Users\用户名\.ssh`
id_rsa      --私钥
id_rsa.pub  -- 公钥

# GitHub 去配置填写生成的公钥信息
# 具体为 Settings -> SSH and GPG keys -> New SSH key -> key的内容就是 公钥 文件中的内容

# 测试 (Linux)
ssh -T git@github.com

# 之后都使用ssh链接上传或clone
```

