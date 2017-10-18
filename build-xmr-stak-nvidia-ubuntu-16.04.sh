#!/bin/bash -uex

osVersion="16.04"
os="ubuntu"
miner="xmr-stak-nvidia"
image_name=$miner-$os-$osVersion
dockerfile=Dockerfile-$miner-$os-$osVersion

if [ -d $miner ]; then
  git -C $miner clean -fdx
else
  git clone https://github.com/rafalsladek/$miner.git $miner
fi

docker build -t $image_name -f $dockerfile .

docker run --rm -it -v $PWD/$miner:/$miner $image_name:latest /bin/bash -c "
set -ex ;
cd /$miner ;
cmake -DCUDA_COMPILER=clang . ;
make install ;
"

mv $miner/bin/$miner bin-nvidia/$image_name
mv $miner/bin/config.txt bin-nvidia/config.txt

git -C $miner clean -fdx