#!/bin/bash

# Install paru-bin (AUR Helper)
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
cd

git clone https://github.com/alokshandilya/suckless.git
cd suckless/dmenu-5.0
sudo make clean install
cd ../dwm
sudo make clean install
cd ../dwmblocks
sudo make clean install
cd ../st
sudo make clean install
cp -r ../.dwm ~/
cd

paru -S bat dash libxft-bgra-git nerd-fonts-jetbrains-mono ttf-fira-code nerd-fonts-fira-code

# Lightdm Entry
cd
sudo mkdir /usr/share/xsessions
sudo touch /usr/share/xsessions/dwm.desktop
echo "[Desktop Entry]" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Encoding=UTF-8" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Name=dwm" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Comment=Dynamic Window Manager" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Exec=~/.dwm/autostart" | sudo tee -a /usr/share/xsessions/dwm.desktop