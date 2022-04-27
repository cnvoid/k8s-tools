#!/bin/sh
sudo kubeadm init --ignore-preflight-errors=NumCPU,Mem --pod-network-cidr=10.88.0.0/16