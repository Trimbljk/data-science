#!/usr/bin/env bash

while :
do
        PORT="`shuf -i 8888-9999 -n 1`"
        ss -lpn | grep -q ":$PORT " || break
done

while getopts 'p:' opt
    do
        case $opt in
            p) PORT=$OPTARG;;
        esac
done

docker run \
    -e "NB_UID=$UID" --user root \
    -e "GRANT_SUDO=yes" \
    -e DATA_DIR \
    --name real-estate-search_$(hostname)_$(id -u) \
    -w $PWD \
    -v $PWD:$PWD \
    -p $PORT:$PORT  -d --rm \
    -v $HOME/.aws:/home/jovyan/.aws \
    trimbljk/real-estate-search start.sh jupyter lab --allow-root --port $PORT
