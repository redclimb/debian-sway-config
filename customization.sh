#!/usr/bin/env bash

## Apply config ##
printf "\033[1;35m Apply config... \033[0m\n"
if [ ! -d $HOME/.config ]; then
    mkdir $HOME/.config
fi
cp -r config/* $HOME/.config/
cp -r backgrounds/ $HOME/.local/

mv $HOME/.bashrc $HOME/.bashrc.orig
cp files/bashrc.ans $HOME/.bashrc
cp files/fzf_bash.ans $HOME/.fzf_bash

## Create Git folder ##
xdg-user-dirs-update
mkdir $HOME/Git

## nwg-look Appearance ##
printf "\033[1;35m Installing nwg-look... \033[0m\n"
sudo apt install -y golang libgtk-3-dev libcairo2-dev libglib2.0-bin zip
cd $HOME/Git
wget https://github.com/nwg-piotr/nwg-look/archive/refs/tags/v0.2.7.zip
unzip v0.2.7.zip
cd nwg-look-0.2.7/
make build
sudo make install
cd ..
rm -r nwg-look-0.2.7/
rm v0.2.7.zip

sudo apt install -y yaru-theme-gtk yaru-theme-icon
