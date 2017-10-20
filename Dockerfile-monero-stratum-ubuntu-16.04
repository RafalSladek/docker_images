FROM ubuntu:16.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq
RUN apt-get install -y -qq software-properties-common git golang libcap2-bin
RUN apt-get install -y -qq build-essential cmake pkg-config libboost-all-dev libssl-dev libzmq3-dev libunbound-dev libminiupnpc-dev libunwind8-dev liblzma-dev libreadline6-dev libldns-dev libexpat1-dev libgtest-dev doxygen graphviz
ENV GOPATH /root/go
RUN go get github.com/goji/httpauth
RUN go get github.com/yvasiyarov/gorelic
RUN go get github.com/gorilla/mux
