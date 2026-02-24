# HOW TO USE THE UPC VPN WITHOUR FORTICLIENT #

In this case we're going to use **openfortivpn** in the version 1.23.1 
For making that possible is very important to have the correct dependencies of the needed libraries (i haven't included the correct ones yet)

Also mention that I have tryed in different linux systems, specifically in ones with systemd or without.

I will do the installation using the **apt** packet manager. If you don't use a Debian-based Linux OS just change it with the one you're currently using.

## PART 1: INSTALLATION OF OPENFORTIVPN WITH THE CORRECT DEPENDENCIES ##

First install the correct package. In Debian will be downloaded by default but in other operating systems may be different. 
```
sudo apt update
sudo apt install openfortivpn
```

For checking that the installation was correct try to ask for the version:
```
openfortivpn --version
```

If the version is 1.23.1 or higher, you can continue with part 2. If you have 1.19.x, you will have to install it manually.

For a manual installation we will use the official upstream repository with the next commands:
```
sudo apt update
sudo apt install build-essential \
		 autoconf automake pkg-config \
		 libssl-dev \
		 libxml2-dev \
		 libproxy-dev
```

Now in your home directory (~/) you will have to clone the official repo:
```
git clone https://github.com/adrienverge/openfortivpn.git
cd openfortivpn
git checkout v1.23.1
```

In $HOME/openfortivpn you will execute the following commands:
```
./autogen.sh
./configure
```

The correct output should look like that:
> SSL support: yes

> SAML support: yes

Now compile it and install it
```
make
sudo make install
```

Finally you will verify that the correct version has been installed with the next commands:
```
which openfortivpn
openfortivpn --version
openfortivpn --help | grep saml
```

* EXTRA: In case you want to uninstall it, run the next command:
> sudo rm /usr/local/bin/openfortivpn 

> sudo rm -rf ~/openfortivpn

## PART 2: USING THE CORRECT COMMAND WITH SAML LOGIN

As we will need SAML login for the VPN, we will use the correct flag with openfortivpn. For further information of the used flags, check *man openfortivpn* :
```
sudo openfortivpn --saml-login myupclink.upc.edu:443 --username <your_upc_username>
```

## EXTRA :) ##

I recommend you to use an alias for the next time, so copy the next into your .bashrc or .bash_aliases:
```
alias vpn-upc='sudo openfortivpn --saml-login myupclink.upc.edu:443 --username <your_upc_username>'
```
Also, if you use a Debian13-based distribution the script-for-debian.sh will do all the job for you (only if the 1.23.1 is installed by default and giving the script execute permission), by typing:
```
./script-for-debian.sh
```

If the previous script failed, try with script-of-manual-installation.sh
```
./script-for-manual-installation.sh
```
