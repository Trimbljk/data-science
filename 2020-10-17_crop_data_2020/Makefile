include set_env.mk

## build-image                                 : Build the docker image for notebooks
build-image: Dockerfile
	docker build -t jkt/2020-10-17_crop_data_2020 . \
	&& touch $@

## run-notebook                                : Run the notebook server
.PHONY: run-notebook
run-notebook: build-image stop-notebook
	DATA_DIR=$(DATA_DIR) ./jupyter-lab.sh

## stop-notebook                               : Stop the notebook server
.PHONY: stop-notebook
stop-notebook:
	docker stop 2020-10-17_crop_data_2020_$(HOSTNAME)_$(UID) || echo "already stopped"
	sleep 1

## get-url                                     : Get the URL of the notebook server
.PHONY: get-url
get-url:
	@docker exec --user jovyan -it 2020-10-17_crop_data_2020_$(HOSTNAME)_$(UID) jupyter notebook list \
	| sed -E "s/(0.0.0.0|localhost)/$(HOSTNAME)/"
