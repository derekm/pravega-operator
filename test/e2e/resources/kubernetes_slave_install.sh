#!/bin/sh

sudo apt-get update
echo "update done"
sudo apt install docker.io -y
echo "docker install"
sudo systemctl enable --now docker
apt-get update && apt-get install -y \
  apt-transport-https ca-certificates curl software-properties-common gnupg2 
echo "installed certs"
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" \
  | sudo tee -a /etc/apt/sources.list.d/kubernetes.list \
  && sudo apt-get update 
sudo apt-get update \
  && sudo apt-get install -yq \
  kubelet \
  kubeadm \
  kubernetes-cni
sudo apt-mark hold kubelet kubeadm kubectl
UUID=`cat /etc/fstab | grep swap | awk '{print $1}' | tr -d "#UUID="` 
sed -i '2 s/^/#/' /etc/fstab
echo "swapoff UUID=$UUID"
swapoff UUID=$UUID