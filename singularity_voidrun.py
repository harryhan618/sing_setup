import time
from inputimeout import inputimeout, TimeoutOccurred
import torch
import torchvision.models as models

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