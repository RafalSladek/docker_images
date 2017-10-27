#!/bin/bash -uex
osVersion="14.04"
os="ubuntu"
miner="monero"
image_name=$miner-$os-$osVersion
dockerfile=Dockerfile-$miner-$os-$osVersion

docker build -t $image_name -f $dockerfile .
docker run --rm -it -v $PWD/:/tmp $image_name:latest /bin/bash
