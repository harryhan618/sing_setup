conda init bash
conda create --name research --file research_conda.txt

sudo apt update
sudo apt upgrade openssh-server -y

eval "$(conda shell.bash hook)"
conda activate research
which python
pip install inputimeout

python ~/sing_setup/singularity_voidrun.py
