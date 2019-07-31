#!/usr/bin/env bash
alias uua='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y'

# gnome tweak
sudo apt install gnome-tweak-tool -y

uua

# docker, without sudo.
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG

# chromium
sudo snap install chromium

# plex
sudo snap install plexmediaserver

# wavebox - email
sudo snap install wavebox

# flameshot - screenshots
sudo apt install flameshot -y

# gitkraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb; sudo dpkg -i gitkraken-amd64.deb

# stracer monitoring
sudo add-apt-repository ppa:oguzhaninan/stacer -y
sudo apt-get update
sudo apt-get install stacer -y
uua