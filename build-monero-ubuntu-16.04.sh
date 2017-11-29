#!/bin/bash -uex

osVersion="16.04"
os="ubuntu"
workdir="monero"
image_name=$workdir-$os-$osVer#sion
dockerfile=Dockerfile-$workdir-$os-$osVersion

if [ ! -d monero ]; then
  git clone https://github.com/monero-project/$workdir.git $workdir
  #git -C monero checkout tags/v0.11.0.0 -b v0.11.0.0 ;
  #curl https://raw.githubusercontent.com/Snipa22/nodejs-pool/master/deployment/monero_daemon.patch | git -C monero apply -v
fi

docker build -t $image_name -f $dockerfile .

docker run --rm -it -v $PWD/$workdir:/$workdir $image_name:latest /bin/bash -c "
set -ex 
cd /$workdir 
make  
"

if [ -d $workdir/build/release/$workdir ]; then
  rm -rf $workdir/build/release/$workdir
fi

cd $workdir/build/release && mv bin $workdir &&  zip -r $workdir.zip $workdir && ls -lh $workdir.zip && mv $workdir.zip ../../../ && rm -rf $workdir
