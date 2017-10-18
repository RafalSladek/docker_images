#!/bin/bash -uex

osVersion="16.04"
os="ubuntu"
miner="xmr-stak-amd"
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
cmake -DCMAKE_LINK_STATIC=ON -DMICROHTTPD_ENABLE=ON -DOpenSSL_ENABLE=ON . ;
make install ;
"

mv $miner/bin/$miner bin-amd/$image_name
mv $miner/bin/config.txt bin-amd/config.txt
mv $miner/bin/opencl bin-amd/opencl

git -C $miner clean -fdx