import torch
from transformers import GenerationConfig, LlamaForCausalLM, LlamaModel, LlamaTokenizer


device_cnt =  torch.cuda.device_count()
device = "cuda:{}".format(device_cnt-1)
device = "cuda"
generation_config = dict(
    temperature=0.2,
    top_k=1,
    top_p=1,
    do_sample=True,
    num_beams=1,
    repetition_penalty=1.3,
    max_new_tokens=100
)

num_request = 64
model_name = "meta-llama/Llama-2-7b-hf"

tokenizer = LlamaTokenizer.from_pretrained(model_name)
tokenizer.pad_token = '</s>'

input_prompt_list = ["why do we need to protect environment?"] * num_request



model = LlamaForCausalLM.from_pretrained(model_name).to(device)



def origin_batch_inference(model, tokenizer, input_texts, generation_config, device="cuda"):
    with torch.no_grad():
        inputs = tokenizer(input_texts, return_tensors="pt", padding=True)
        generation_outputs = model.generate(
                               input_ids = inputs["input_ids"].to(device),
                               attention_mask = inputs['attention_mask'].to(device),
                               eos_token_id=tokenizer.eos_token_id,
                               pad_token_id=tokenizer.pad_token_id,
                               **generation_config
)


while 1:
    origin_batch_inference(model, tokenizer, input_prompt_list, generation_config)
    print("Finish one request")
