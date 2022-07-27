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
# gd is required for my build of st
paru -S gd
mkdir ~/Documents
git clone https://github.com/alokshandilya/suckless.git ~/Documents/suckless
cd ~/Documents/suckless/dwm
sudo make clean install
cd ../dwmblocks
sudo make clean install
cd ../st
sudo make clean install
cp -r ../.dwm ~/
cd

#########################################
##### Installing fonts and packages #####
#########################################
printf "\n"
printf "#########################################\n"
printf "##### Installing fonts and packages #####\n"
printf "#########################################\n\n"
#paru -S --needed libxft-bgra 
paru -S --needed nerd-fonts-jetbrains-mono ttf-fira-code nerd-fonts-fira-code
paru -S --needed wget bat dash

paru -S --needed lxappearance-gtk3 numlockx copyq conky feh bpytop ranger rofi nitrogen kvantum-qt5 kvantum-theme-materia qt5ct dunst thunar
paru -S --needed brightnessctl xsel jdk-openjdk nvtop cmake libva-utils clang llvm ueberzug

# lightdm
paru -S --needed lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm

# polkit
paru -S --needed polkit-gnome gnome-keyring lxsession

##########################################
##### Creating desktop entry for dwm #####
##########################################
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
