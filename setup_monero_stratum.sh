#!/bin/bash -eux
 export DEBIAN_FRONTEND=noninteractive
 apt-get update -qq
 apt-get install -y -qq software-properties-common git golang libcap2-bin
 apt-get install -y -qq build-essential cmake pkg-config libboost-all-dev libssl-dev libzmq3-dev libunbound-dev libminiupnpc-dev libunwind8-dev liblzma-dev libreadline6-dev libldns-dev libexpat1-dev libgtest-dev doxygen graphviz
 export GOPATH=/root/go
 go get github.com/goji/httpauth
 go get github.com/yvasiyarov/gorelic
 go get github.com/gorilla/mux