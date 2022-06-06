# Overview

This is an official repo for our The 4th Large-scale Video Object Segmentation Challenge solutions for Referring Video Object Segmentation([Track3](https://youtube-vos.org/dataset/rvos/)). Our team TAL-AI achieved the best performance on Referring Video Object Segmentation([Leaderboard](https://codalab.lisn.upsaclay.fr/competitions/3282#results)). More details about the workshop can be found [here](https://youtube-vos.org/challenge/2022/).

Our code is based on [ReferFormer](https://github.com/wjn922/referformer) and [AOT](https://github.com/yoxu515/aot-benchmark).

## Requirements

We test the codes in the following environments, other versions may also be compatible:
- CUDA 10.2
- Python 3.8
- Pytorch 1.9.0

## Installation
Please refer to [ReferFormer](ReferFormer/docs/install.md) and [AOT](AOT/README.md) for installation.

## Data Preparation
Please refer to [ReferFormer](ReferFormer/docs/data.md) and [AOT](AOT/README.md) for data preparation.

## Get Started

###First, finetune the video-swin-base model (Execute in the ./ReferFormer directory)

```
./finetune.sh
```
You can also download our model [here]().
###Secondly, test our model and get [Annotations] / [key_frame.json].

```
./scripts/test_ytvos.sh \
[/path/to/output_dir] \
[/path/to/pretrained_weight] \
--part_name [saved-model-name] \
--cuda_id 0 \
--dataset_file ytvos \
--ytvos_path [/path/to/ref-ytb-dataset]
```

###Then, send [key_frame.json] and [Annotations] to AOT, and get refined results (Execute in the ./AOT directory).
#### We retrain the AOT network with Swin-L as the backbone, and the specific training parameters were consistent with the default [AOT](AOT/README.md) setting.

```
./train_eval.sh
```
You can also download our model [here]().
#### Then run the following script to perform the Bi-directional post-process.

```
./eval.sh
```
You may modify some path information [here](AOT/configs/default.py)

### Finally, executing model ensemble.
#### We initially fused our results before the final results were fused. You need to run this script to save .pth results. 

```
./ensemble_test.sh \
[/path/to/pretrained_weight] \
--ytvos_path [/path/to/ref-ytb-dataset]
--ensemble_save_path [/path/to/save/.pth-file]
```


Our trained models for inference can be downloaded from the link below.

|  Model_Name   | Weights  |
|  ----  | ----  |
| ReferFormer(Video-Swin-B_FT)	  |  [weights](https://drive.google.com/file/d/18a96TEj8yY3Nb0Xf5WFLKmxPaazaFQ02/view?usp=sharing) |
| ReferFormer(Video-Swin-B)  | [weights](https://drive.google.com/file/d/19XO5VoR6qTE3VNLF-IjYzabL-2tb9E14/view) |
| ReferFormer(Swin_L) | [weights](https://drive.google.com/file/d/1JeppEr8m0O9844xncSfSZrYE_NH8oXb7/view) |
| AOT(Swin_L) | [weights](https://drive.google.com/file/d/13Fq7DhQETxCRPkU53ggLSWYn4-qrPz8V/view?usp=sharing) |

#### Then, run this script to get [Annotations] and [key_frame.json] for the fusion model, and send these files to AOT for post-process.

```
python test_swap.py \
--pth_model_path [/path/to/saved_pth_weights] \
--ytvos_path [/path/to/ref-ytb-dataset] \
--output_dir [/path/to/output_dir]
```
#### Finally, fusing all AOT results.

```
python test_ensemble.py \
--mask_root [/path/to/AOT_results_dir]
--ytvos_path [/path/to/ref-ytb-dataset]
--output_dir [/path/to/output_dir]
```
You may modify some path information [here](ReferFormer/test_ensemble.py)