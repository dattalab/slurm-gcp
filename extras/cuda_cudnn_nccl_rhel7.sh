# how to get cuda, cudnn, nccl installed and working from scratch on rhel7


# get kernel headers and cuda repo, install appropriate version for tf
sudo yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
wget http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.0.176-1.x86_64.rpm
sudo rpm -i cuda-repo-rhel7-9.0.176-1.x86_64.rpm
sudo yum clean all
sudo yum -y install cuda-9-0
sudo nvidia-smi -pm 1

# from https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html
wget https://storage.googleapis.com/cluster-deployment/cudnn-9.0-linux-x64-v7.4.1.5.tgz
tar -xzvf cudnn-9.0-linux-x64-v7.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

# from https://docs.nvidia.com/deeplearning/sdk/nccl-install-guide/index.html
wget https://storage.googleapis.com/cluster-deployment/nccl_2.3.7-1%2Bcuda9.0_x86_64.txz
tar xvf nccl_2.3.7-1%2Bcuda9.0_x86_64.txz
sudo mv nccl_2.3.7-1%2Bcuda9.0_x86_64 /usr/local/

# check bashrc for exports
# NOW install TF in conda/pip/whatever
