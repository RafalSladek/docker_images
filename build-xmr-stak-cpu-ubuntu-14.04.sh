#!/bin/bash -uex

osVersion="14.04"
os="ubuntu"
miner="xmr-stak-cpu"
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
cmake -DCMAKE_LINK_STATIC=ON -DMICROHTTPD_ENABLE=ON -DOpenSSL_ENABLE=ON -DHWLOC_ENABLE=ON . ;
make install ;
"

mv $miner/bin/$miner bin/$image_name
mv $miner/bin/config.txt bin/config.txt
git -C $miner clean -fdx