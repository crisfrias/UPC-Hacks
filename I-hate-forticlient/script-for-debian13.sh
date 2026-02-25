#!/bin/bash
set -euo pipefail

# First we install the correct package
apt update
apt install openfortivpn

# We will need the upc user for the vpn connection
echo "What's your UPC user?"
read UPC_USER

# Now we will add the vpn-upc alias to bashrc
ALIASES="$HOME/.bash_aliases"
BASHRC="$HOME/.bashrc"

if [[ -e "$ALIASES" ]]; then
  echo "Using $ALIASES"
  FILE="$ALIASES"
else
  echo "$ALIASES doesn't exist, using $BASHRC"
  FILE="$BASHRC"
fi

touch "$FILE"

if grep -qE '^[[:space:]]*alias[[:space:]]+vpn-upc=' "$FILE"; then
	sed -i -E "s|^[[:space:]]*alias[[:space:]]+vpn-upc=.*$|alias vpn-upc='sudo openfortivpn --saml-login myupclink.upc.edu:443 --username ${UPC_USER}'|" "$FILE"
else
	echo "alias vpn-upc='sudo openfortivpn --saml-login myupclink.upc.edu:443 --username ${UPC_USER}'" >> "$FILE"
fi

# Finally, in the terminal it will say that the vpn was correctly configured
echo "Openfortivpn was correctly installed. For using it, run source ~/.bashrc and try to type vpn-upc after that :)"
