#!/bin/bash -uex

osVersion="16.04"
os="ubuntu"
miner="monero"
image_name=$miner-$os-$osVersion
dockerfile=Dockerfile-$miner-$os-$osVersion

if [ ! -d monero ]; then
  git clone https://github.com/monero-project/monero.git monero
  git -C monero checkout tags/v0.11.0.0 -b v0.11.0.0 ;
  curl https://raw.githubusercontent.com/Snipa22/nodejs-pool/master/deployment/monero_daemon.patch | sudo git apply -v
fi

docker build -t $image_name -f $dockerfile .

docker run --rm -it -v $PWD/$miner:/$miner -v $PWD/monero:/monero $image_name:latest /bin/bash -c "
set -ex ;
cd /monero ;
cmake -DBUILD_SHARED_LIBS=1 . ;
make -j$(nproc)
"
#cp -rf monero/bin monero-pool

#./pool config.json