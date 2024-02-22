import time
from inputimeout import inputimeout, TimeoutOccurred
import torch
import torchvision.models as models

import subprocess

def get_gpu_memory_usage():
    """Return the current GPU memory usage in MB for the first GPU."""
    result = subprocess.run(['nvidia-smi', '--id=0', '--query-gpu=memory.used', '--format=csv,nounits,noheader'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if result.returncode != 0:
        raise RuntimeError("Failed to get GPU memory usage: " + result.stderr.decode('utf-8'))
    output = result.stdout.decode('utf-8').strip()
    memory_usage = int(output)
    return memory_usage

device_cnt =  torch.cuda.device_count()
device = "cuda:{}".format(device_cnt-1)

def run():
    idx = 0
    while 1:
        model = models.wide_resnet101_2().to(device)
        x1 = torch.rand(32, 3, 224, 224).to(device)
        x2 = torch.rand(32, 3, 224, 224).to(device)
        x = x1 + x2
        y = model(x)
        idx += 1
        if idx % 200 == 0:
            print(idx)

        try:
            string = inputimeout(prompt='Pause for a while?', timeout=0.3)
            print("Sleep for 25 mins")

            return
        except TimeoutOccurred:
            pass

while 1:
    run()
    torch.cuda.empty_cache()
    time.sleep(60*25)
