#!/bin/bash

sudo apt update
sudo apt install build-essential \
		 autoconf automake pkg-config \
		 libssl-dev \
		 libxml2-dev \
		 libproxy-dev

git clone https://github.com/adrienverge/openfortivpn.git
cd openfortivpn
git checkout v1.23.1

./autogen.sh
./configure

make 
sudo make install
openfortivpn --version
