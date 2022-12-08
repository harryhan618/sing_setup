echo "" >> ~/.profile
echo "cd ~" >> ~/.profile
echo "source ~/.bashrc" >> ~/.profile



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
conda create --name research --file research_conda.txt

eval "$(conda shell.bash hook)"
conda activate research
which python
pip install inputimeout

python ~/sing_setup/singularity_voidrun.py
