# 一. 目录

## 1. */etc/systemd/system/*

`systemd`服务的储存位置
`systemd`: 系统和服务管理器，用于控制 Linux 系统的启动过程和服务管理

### 1.1 以配置 clash 开机自启为例

#### 1.1.1 配置 */etc/systemd/system/clash.service* 文件

```shell
sudo vim /etc/systemd/system/clash.service
```

```properties
# 描述该服务的基本信息，如服务的名称、描述、启动顺序等。
[Unit]
Description=clash service
After=network.target
# After=network.target: 依赖于 network.target，意味着它将在网络服务启动后启动

[Service]
ExecStart=/home/sxy/clash-Linux/clash -d /home/sxy/clash-Linux/  
# ExecStart: 服务的具体行为

[Install]
WantedBy=multi-user.target 
# WantedBy: 该服务应该被安装在 multi-user.target 中
# multi-user.target: Linux 系统中一个标准的 target，表示多用户模式
```

####  1.1.2 systemctl 配置开机启动

```sh
sudo systemctl daemon-reload # 刷新配置
sudo systemctl start clash # 启动clash.service
sudo systemctl enable clash # 设置开机启动
sudo systemctl status clash # 查看clash.service的状态
```

## 2. /etc/sudoers

```shell
# 配置用户是否可以使用 sudo
```

# 