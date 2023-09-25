```sh
# 生成 SSH Key
ssh-keygen -t rsa -C "user1@email.com"

# create to ~/.ssh
id_rsa      --私钥
id_rsa.pub  -- 公钥

# GitHub 去配置填写生成的公钥信息

# 测试
ssh -T git@github.com
```

