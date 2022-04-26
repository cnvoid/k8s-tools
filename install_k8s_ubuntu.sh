#!/bin/sh
## 安装 docker
 apt install docker.io -y
 
 echo "{
	"registry-mirrors": [

		"https://registry.docker-cn.com"

	]

}" > /etc/docker/daemon.json

systemctl daemon-reload
systemctl restart docker

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubeadm"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubeadm


curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubelet"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubelet