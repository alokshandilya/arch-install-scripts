#!/bin/bash

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

paru -S libxft-bgra-git

# Lightdm Entry
cd
sudo touch /usr/share/xsessions/dwm.desktop
echo "[Desktop Entry]" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Encoding=UTF-8" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Name=dwm" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Comment=Dynamic Window Manager" | sudo tee -a /usr/share/xsessions/dwm.desktop
echo "Exec=~/.dwm/autostart" | sudo tee -a /usr/share/xsessions/dwm.desktop
