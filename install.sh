#!/bin/sh
echo "deb http://deb.debian.org/debian stretch-backports main contrib non-free" >> /etc/apt/sources.list
sed -i "s/ main/ main contrib non-free/" /etc/apt/sources.list
apt-get update && apt-get install apt-transport-https -y
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -

echo "
deb https://nvidia.github.io/libnvidia-container/debian9/amd64 /
deb https://nvidia.github.io/nvidia-container-runtime/debian9/amd64 /
deb https://nvidia.github.io/nvidia-docker/debian9/amd64 /
" > /etc/apt/sources.list.d/nvidia-docker.list

apt-get update
apt-get install --no-install-recommends -y dkms linux-headers-amd64 fakeroot nvidia-docker2=2.0.3+docker18.06.2-2 nvidia-container-runtime=2.0.0+docker18.06.2-2
apt-get install --no-install-recommends -y -t stretch-backports nvidia-kernel-dkms libcuda1 libnvidia-ml1 nvidia-smi

echo '{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}' > /etc/docker/daemon.json

systemctl reload docker.service
