#!/bin/bash -uex

osVersion="17.04"
os="ubuntu"
miner="xmrig"
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
mkdir bin
cd bin
cmake .. -DWITH_LIBCPUID=ON -DWITH_AEON=ON -DWITH_HTTPD=ON;
make  ;
"

mv $miner/bin/$miner bin/$image_name
cp $miner/src/config.json bin/config.json
git -C $miner clean -fdx