alias uua='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y'
set -u

#############################################
# 1. Linux Quality of Life Apps & Packages  #
#############################################

# bpytop system monitoring
sudo apt install python3 idle3
pip3 install bpytop --upgrade



#############################################
# 2. Languages  #
#############################################

# Node 10.23 for rPi 
wget https://nodejs.org/dist/latest-v10.x/node-v10.23.0-linux-armv6l.tar.gz
tar -xzf node-v10.23.0-linux-armv6l.tar.gz
sudo cp -r node-v10.23.0-linux-armv6l/* /usr/local/

# Rust
curl --proto '=https'  --tlsv1.2 https://sh.rustup.rs -sSf | sh


#############################################
# 3. Development  #
#############################################

# Neovim
sudo apt install neovim

# code-server - only for >= rpi 4 
curl -fsSL https://code-server.dev/install.sh | sh