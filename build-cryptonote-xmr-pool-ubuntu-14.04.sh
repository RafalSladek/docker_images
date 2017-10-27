#!/bin/bash -uex

osVersion="14.04"
os="ubuntu"
miner="cryptonote-xmr-pool"
image_name=$miner-$os-$osVersion
dockerfile=Dockerfile-$miner-$os-$osVersion

docker build -t $image_name -f $dockerfile .
docker run --rm -it -v $PWD/:/src $image_name:latest /bin/bash
