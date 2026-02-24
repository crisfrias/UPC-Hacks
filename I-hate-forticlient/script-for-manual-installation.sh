#!/bin/bash

# First we install the dependencies
sudo apt update
sudo apt install build-essential \
		 autoconf automake pkg-config \
		 libssl-dev \
		 libxml2-dev \
		 libproxy-dev

# We clone the upstream repository and change to the desired branch
git clone https://github.com/adrienverge/openfortivpn.git
cd openfortivpn
git checkout v1.23.1

# Execute the needed configuration
./autogen.sh
./configure

# Compile and install
make 
sudo make install

# Show in terminal that the installation was successfull
echo "The installation of the openfortivpn in 1.23.1 was successfull. Watch the version with openfortivpn --version"
