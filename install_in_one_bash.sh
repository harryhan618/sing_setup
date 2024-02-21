apt update 
apt install -y vim 
apt install -y git
apt install -y tmux 

wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
sh Anaconda3-2023.09-0-Linux-x86_64.sh -b -p ./anaconda && ./anaconda/bin/conda init

conda init bash
eval "$(conda shell.bash hook)"


alias proxyon="export http_proxy=http://127.0.0.1:10080;export https_proxy=http://127.0.0.1:10080"
alias proxyoff="unset http_proxy;unset https_proxy"


# voidrun
cd ~/sing_setup
conda create --name research --file research_conda.txt
conda activate research
which python
pip install inputimeout
python ~/sing_setup/singularity_voidrun.py
