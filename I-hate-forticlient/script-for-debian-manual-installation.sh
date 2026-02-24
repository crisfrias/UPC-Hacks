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

# We will need the upc user for the vpn connection
echo "What's your UPC user?"
read UPC_USER

# Now we will add the vpn-upc alias to bashrc
ALIASES=$HOME/.bash_aliases

if grep -qE '^[[:space:]]*alias[[:space:]]+vpn-upc=' "$ALIASES"; then
	sed -i -E "s|^[[:space:]]*alias[[:space:]]+vpn-upc=.*$|alias vpn-upc='sudo openfortivpn --saml-login myupclink.upc.edu:443 --username ${UPC_USER}'|" "$ALIASES"
else
	echo "alias vpn-upc='sudo openfortivpn --saml-login myupclink.upc.edu:443 --username ${UPC_USER}'" >> "$ALIASES"
fi

# Finally, in the terminal it will say that the vpn was correctly configured
echo "Openfortivpn was correctly installed. For using it, run source ~/.bash_aliases and try to type vpn-upc after that :)"
