#!/bin/sh
swapoff -a
sed 's/\/swap.img/#\/swap.img/g' /etc/fstab

Environment="KUBELET_SYSTEM_PODS_ARGS=--pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true --fail-swap-on=false"
systemctl daemon-reload



echo 'export http_proxy=socks5://10.0.0.52:1080
export https_proxy=socks5://10.0.0.52:1080
export no_proxy="*.aiezu.com,10.*.*.*,192.168.*.*,*.local,localhost,127.0.0.1"' >> /etc/profile

source /etc/profile

sudo kubeadm init --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers' --ignore-preflight-errors=NumCPU,Mem --pod-network-cidr=10.88.0.0/16 --v=5