#!/usr/bin/env bash

echo ${DATA_DIR}

docker run  \
    -e "DATA_DIR=${DATA_DIR}" \
    -e PROD_DB \
    -w ${PWD} \
    -v ${PWD}:${PWD} \
    -v $HOME/.aws:/home/jovyan/.aws \
    --user root -e "NB_UID=${UID}" \
    agbiome/200327_new_format_aes \
    start.sh $@
