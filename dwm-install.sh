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
sudo touch /usr/share/xsessions/dwm.desktop
echo "[Desktop Entry]" >> /usr/share/xsession/dwm.desktop
echo "Encoding=UTF-8" >> /usr/share/xsession/dwm.desktop
echo "Name=dwm" >> /usr/share/xsession/dwm.desktop
echo "Comment=Dynamic Window Manager" >> /usr/share/xsession/dwm.desktop
echo "Exec=~/.dwm/autostart" >> /usr/share/xsession/dwm.desktop
