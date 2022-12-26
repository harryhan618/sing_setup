echo "" >> ~/.profile
echo "cd ~" >> ~/.profile
echo "source ~/.bashrc" >> ~/.profile

cd ~

# openssh
sudo apt update
sudo apt upgrade openssh-server -y

# nccl
sudo apt update
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt update
sudo apt install libnccl2 libnccl-dev


# torch
conda init bash
eval "$(conda shell.bash hook)"

# megatronlm
mkdir /home/aiscuser/Software
wget https://developer.download.nvidia.com/compute/cuda/11.6.0/local_installers/cuda_11.6.0_510.39.01_linux.run
sh cuda_11.6.0_510.39.01_linux.run --silent --toolkit --installpath=/home/aiscuser/Software/cuda-11.6
echo "export CUDA_HOME=/home/aiscuser/Software/cuda-11.6" >> /home/aiscuser/.bashrc
echo "export PATH=/home/aiscuser/Software/cuda-11.6/bin:$PATH" >> /home/aiscuser/.bashrc
echo "export LD_LIBRARY_PATH=/home/aiscuser/Software/cuda-11.6/lib64:$LD_LIBRARY_PATH" >> /home/aiscuser/.bashrc

conda create -n megatronlm -y
git clone https://github.com/NVIDIA/apex /home/aiscuser/Software/apex
conda activate megatronlm
conda install python=3.9 -y
conda install ipython -y
pip install packaging
pip3 install numpy==1.23.5 torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
cd /home/aiscuser/Software/apex
python setup.py develop --cpp_ext --cuda_ext
cd ~
git clone https://github.com/NVIDIA/Megatron-LM
cd Megatron-LM
python setup.py develop
pip install regex
conda install pybind11 -y

cd ~


# voidrun
conda create --name research --file research_conda.txt
conda activate research
which python
pip install inputimeout
python ~/sing_setup/singularity_voidrun.py
