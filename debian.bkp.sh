#!/usr/bin/env bash
dpkg --get-selections > /home/avelino/dotfiles/debian.packages
apt-key exportall > /home/avelino/dotfiles/debian.repokeys
cat /etc/apt/sources.list > /home/avelino/dotfiles/debian.sources
cp /etc/apt/sources.list.d/*.list /home/avelino/dotfiles/debian.sources.list.d/
