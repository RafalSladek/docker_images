#!/bin/bash -uex

osVersion="16.04"
os="ubuntu"
pool="nodejs-pool"
poolui="poolui"
image_name=$pool-$os-$osVersion
dockerfile=Dockerfile-$pool-$os-$osVersion

if [ ! -d $pool ]; then
  git clone git@gitlab.com:crypto-pool/$pool.git $pool
fi

if [ ! -d $poolui ]; then
  git clone git@gitlab.com:crypto-pool/$poolui.git $poolui
fi

if [ ! -d monero ]; then
  git clone https://github.com/monero-project/monero.git monero
fi

docker build -t $image_name -f $dockerfile .

docker run --rm -it -v $PWD/$pool:/$pool v $PWD/$poolui:/$poolui -v /tmp/:/blockchain $image_name:latest /bin/bash 
