#!/bin/bash -uex

osVersion="16.04"
os="ubuntu"
miner="monero-stratum"
image_name=$miner-$os-$osVersion
dockerfile=Dockerfile-$miner-$os-$osVersion

if [ -d $miner ]; then
  git -C monero clean -fdx
  git -C $miner clean -fdx
else
  git clone https://github.com/monero-project/monero.git monero
  git clone https://github.com/rafalsladek/$miner.git $miner
fi

docker build -t $image_name -f $dockerfile .

docker run --rm -it -v $PWD/$miner:/$miner -v $PWD/monero:/monero $image_name:latest /bin/bash -c "
set -ex ;
cd /monero ;
git checkout tags/v0.11.0.0 -b v0.11.0.0 ;
cmake -DBUILD_SHARED_LIBS=1 . ;
make; 

cd /$miner
MONERO_DIR=/monero cmake .
make
"

mv monero/build/bin monero-pool

git -C monero clean -fdx
git -C $miner clean -fdx