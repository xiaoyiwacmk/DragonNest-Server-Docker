# 仓库简介

该仓库提供了创建 ***DragonNest 单节点服务器*** (以下简称 *DN*) 的 Docker 镜像的源码，目前支持以下版本：

- 符文龙
- 腹黑龙
- 飓风龙

## Docker 安装

> 过程中会出现让你确任是否添加 gpg 密钥，直接回车

```sh
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y
```

## 使用方法

1. 复制服务端中的 data 文件夹的内容到 data 文件夹

2. 复制服务端中的 usr 文件夹的内容到 usr 文件夹

3. 生产 docker 镜像

```sh
docker build -t wacmk-dn-{server_type}:{tag}.

# server_type: 服务端类型，如 符文龙

# tag: 镜像版本号
## 稳定版
### latest 最新稳定版，指向最新的 x.y.z 版
### x，指向 x 版下最新的 x.y.z 版
### x.y， 指向 x.y 版下最新的 x.y.z 版
### x.y.z，某个具体的版本

## 测试版
### x.y.z-alpha, 内部测试版，不提供简短 tag
### x.y.z-beta，公开测试版，不提供简短 tag
```

