#!/bin/bash -uex

osVersion="16.04"
os="ubuntu"
miner="monero-stratum"
image_name=$miner-$os-$osVersion
dockerfile=Dockerfile-$miner-$os-$osVersion

if [ -d $miner ]; then
  git -C $miner clean -fdx
else
  git clone https://github.com/RafalSladek/$miner.git $miner
fi

if [ -d monero ]; then
 git -C monero clean -fdx
else
  git clone https://github.com/monero-project/monero.git monero
  git -C monero checkout tags/v0.11.0.0 -b v0.11.0.0 ;
fi

docker build -t $image_name -f $dockerfile .

docker run --rm -it -v $PWD/$miner:/$miner -v $PWD/monero:/monero $image_name:latest /bin/bash -c "
set -ex ;
cd /monero ;
cmake -DBUILD_SHARED_LIBS=1 . ;
make; 

cd /$miner
MONERO_DIR=/monero 
cmake .
make
"
#cp -rf monero/bin monero-pool

#./build/bin/monero-stratum config.json