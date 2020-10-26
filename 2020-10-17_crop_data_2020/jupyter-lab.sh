#!/usr/bin/env bash

while :
do
        PORT="`shuf -i 8888-9999 -n 1`"
        break
done

docker run \
    -e "NB_UID=$UID" --user root \
    -e "GRANT_SUDO=yes" \
    -e DATA_DIR \
    -e USDAKEY \
    -e ATHENA_RESULTS \
    -e CROP_BUCKET \
    -e AWS_LP \
    --name 2020-10-17_crop_data_2020_$(hostname)_$(id -u) \
    -w $PWD \
    -v $PWD:$PWD \
    -p $PORT:$PORT  -d --rm \
    -v $HOME/.aws:/home/jovyan/.aws \
    jkt/2020-10-17_crop_data_2020 start.sh jupyter lab --allow-root --port $PORT
