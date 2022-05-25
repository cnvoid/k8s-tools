#!/bin/sh


echo 'export http_proxy=http://10.10.23.23:20171
export https_proxy=http://10.10.23.23:20171
export no_proxy="*.aiezu.com,10.*.*.*,192.168.*.*,*.local,localhost,127.0.0.1"' >> /etc/profile

source /etc/profile

sudo kubeadm reset
sudo kubeadm init --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers' --ignore-preflight-errors=NumCPU,Mem --pod-network-cidr=10.88.0.0/16 --v=5

# kubeadm join 10.30.21.143:6443 --token comn2d.501rx32ap2s1alzt \
#        --discovery-token-ca-cert-hash sha256:58801f6d0a7169a8e0ce9f276eda52a3873b95f51942ce5d0e9a3afdd4089a9a 

echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile

source ~/.bash_profile


# 安装网络插件
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# 安装 dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml

# 添加面板用户   
#kubectl apply -f ./add_cluster_admin_user.yml

# 获取面板登录token 
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
# dashbord https://github.com/kubernetes/dashboard

kubectl proxy

kubeadm token generate

 kubeadm token list

 kubeadm token create --print-join-command --ttl=0