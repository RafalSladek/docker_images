#!/bin/bash -uex

osVersion="14.04"
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
cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 -DWITH_LIBCPUID=ON -DWITH_AEON=ON -DWITH_HTTPD=ON -DUV_LIBRARY=/usr/local/lib/libuv.a;
make  ;
"

mv $miner/bin/$miner bin/$image_name
mv $miner/src/config.json bin/config.json
git -C $miner clean -fdx