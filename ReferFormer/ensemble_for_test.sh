./scripts/ensemble_test.sh
[/path/to/model_weights] \
--backbone [backbone] \
--use_checkpoint \
--cuda_id 0 \
--ensemble_save_path [/path/to/save_pth_model] \
--ytvos_path [/path/to/ref-ytb-test]