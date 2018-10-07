#!/usr/bin/env bash

## install packages for debian
sudo apt-key add debian.repokeys
sudo cp debian.sources /etc/apt/sources.list && sudo cp debian.sources.list.d/* /etc/apt/sources.list.d/
sudo apt update && sudo apt upgrade && sudo apt-get install dselect
sudo dselect update && sudo dpkg --set-selections < debian.packages && sudo apt-get dselect-upgrade -y