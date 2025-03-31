#!/bin/sh
## 安装 docker
apt install docker.io -y

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

echo '{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://registry.cn-hangzhou.aliyuncs.com"
  ]
}' > /etc/docker/daemon.json

systemctl daemon-reload
systemctl restart docker

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

add-apt-repository "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main"

sudo apt update && apt --fix-broken install && apt install -y kubelet kubeadm kubectl
systemctl enable kubelet.service

apt install socat  conntrack -y

curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

swapoff -a
sed 's/\/swap.img/#\/swap.img/g' /etc/fstab

Environment="KUBELET_SYSTEM_PODS_ARGS=--pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true --fail-swap-on=false"
systemctl daemon-reload
