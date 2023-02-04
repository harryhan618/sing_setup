echo "" >> ~/.profile
echo "cd ~" >> ~/.profile
echo "source ~/.bashrc" | sudo tee -a ~/.profile

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
mkdir $HOME/Software
wget https://developer.download.nvidia.com/compute/cuda/11.6.0/local_installers/cuda_11.6.0_510.39.01_linux.run
sh cuda_11.6.0_510.39.01_linux.run --silent --toolkit --installpath=$HOME/Software/cuda-11.6
echo "export CUDA_HOME=$HOME/Software/cuda-11.6" >> $HOME/.bashrc
echo "export PATH=$HOME/Software/cuda-11.6/bin:$PATH" >> $HOME/.bashrc
echo "export LD_LIBRARY_PATH=$HOME/Software/cuda-11.6/lib64:$LD_LIBRARY_PATH" >> $HOME/.bashrc

conda create -n megatronlm -y
git clone https://github.com/NVIDIA/apex $HOME/Software/apex
conda activate megatronlm
conda install python=3.9 -y
conda install ipython -y
pip install packaging
pip3 install numpy==1.23.5 torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
cd $HOME/Software/apex
python setup.py develop --cpp_ext --cuda_ext
cd ~
git clone https://github.com/NVIDIA/Megatron-LM
cd Megatron-LM
python setup.py develop
pip install regex
conda install pybind11 -y

cd ~

# alpa
conda create -n alpa -y
conda activate megatronlm
conda install python=3.9 -y
conda install ipython -y
pip3 install cupy-cuda116
pip3 install alpa
pip3 install jaxlib==0.3.22+cuda113.cudnn820 -f https://alpa-projects.github.io/wheels.html
cd ~

# voidrun
conda create --name research --file research_conda.txt
conda activate research
which python
pip install inputimeout
python ~/sing_setup/singularity_voidrun.py
