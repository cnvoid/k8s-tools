#!/bin/sh
## 安装 docker
 apt install docker.io -y
 
 echo '{
	"registry-mirrors": [

		"https://registry.docker-cn.com"

	]

}' > /etc/docker/daemon.json

systemctl daemon-reload
systemctl restart docker

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

add-apt-repository "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main"

sudo apt update && apt install -y kubelet kubeadm kubectl
systemctl enable kubelet.service

apt install socat  conntrack -y

curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
