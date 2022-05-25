#!/bin/bash

########################################
##### Installing paru (AUR Helper) #####
########################################
if ! command -v paru &> /dev/null
then
    printf "\n"
    printf "########################################\n"
    printf "##### Installing paru (AUR Helper) #####\n"
    printf "########################################\n\n"
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si
else
    printf "\n"
    printf "#######################################\n"
    printf "###### paru is already installed ######\n"
    printf "#######################################\n"
fi

printf "\n"
printf "#########################################\n"
printf "##### Installing suckless utilities #####\n"
printf "#########################################\n\n"
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

printf "\n"
printf "#########################################\n"
printf "##### Installing fonts and packages #####\n"
printf "#########################################\n\n"
paru -S libxft-bgra nerd-fonts-jetbrains-mono ttf-fira-code nerd-fonts-fira-code
paru -S wget bat dash powerpill

paru -S lxappearance numlockx copyq conky feh bpytop ranger rofi nitrogen capitaine-cursors kvantum-qt5 kvantum-theme-materia qt5ct dunst arc-gtk-theme arc-icon-theme thunar lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan lightdm-gtk-greeter

sudo systemctl enable lightdm

# polkit
paru -S gnome-keyring lxsession


# Lightdm Entry
printf "\n"
printf "##########################################\n"
printf "##### Creating desktop entry for dwm #####\n"
printf "##########################################\n\n"
cd
DIR="/usr/share/xsessions"
if [ -d "$DIR" ]; then
    FILE=/usr/share/xsessions/dwm.desktop
    if [ -f "$FILE" ]; then
        printf "$FILE exists\n"
        sudo rm -rf /usr/share/xsessions/dwm.desktop
    fi
    sudo touch /usr/share/xsessions/dwm.desktop
    echo "[Desktop Entry]" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Encoding=UTF-8" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Name=dwm" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Comment=Dynamic Window Manager" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Exec=~/.dwm/autostart" | sudo tee -a /usr/share/xsessions/dwm.desktop
else
    sudo mkdir /usr/share/xsessions
    sudo touch /usr/share/xsessions/dwm.desktop
    echo "[Desktop Entry]" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Encoding=UTF-8" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Name=dwm" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Comment=Dynamic Window Manager" | sudo tee -a /usr/share/xsessions/dwm.desktop
    echo "Exec=~/.dwm/autostart" | sudo tee -a /usr/share/xsessions/dwm.desktop
fi

printf "\n"
printf "##########################################\n"
printf "###### dwm is successfully installed######\n"
printf "##########################################\n\n"
