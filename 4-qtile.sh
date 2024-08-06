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
printf "###############################\n"
printf "##### Installing Packages #####\n"
printf "###############################\n\n"

paru -S --needed ttf-jetbrains-mono-nerd ttf-firacode-nerd
paru -S --needed wget bat dash ttf-fira-code ttf-jetbrains-mono

paru -S --needed nwg-look numlockx copyq conky swww feh bpytop ranger rofi-wayland kvantum kvantum-theme-materia
paru -S --needed qt6ct dunst ffmpegthumbnailer xarchiver gammastep xdg-desktop-portal xdg-desktop-portal-wlr grim flameshot brightnessctl cliphist wl-clipboard galculator

# lightdm
#paru -S --needed lightdm lightdm-gtk-greeter
#sudo systemctl enable lightdm

# polkit
paru -S --needed polkit-gnome gnome-keyring

printf "\n"
printf "################################################\n"
printf "###### Packages are successfully installed######\n"
printf "################################################\n\n"



printf "\n"
printf "############################\n"
printf "##### Installing Qtile #####\n"
printf "############################\n\n"

mv ~/.config/qtile ~/.config/qtile.bak
git clone https://github.com/alokshandilya/qtile.git ~/.config/qtile

#printf "\n"
#printf "############################################\n"
#printf "##### Creating desktop entry for Qtile #####\n"
#printf "############################################\n\n"
#cd
#DIR="/usr/share/xsessions"
#if [ -d "$DIR" ]; then
#  FILE=/usr/share/xsessions/dwm.desktop
#  if [ -f "$FILE" ]; then
#    printf "$FILE exists\n"
#    sudo rm -rf /usr/share/xsessions/dwm.desktop
#  fi
#  sudo touch /usr/share/xsessions/dwm.desktop
#  echo "[Desktop Entry]" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Encoding=UTF-8" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Name=dwm" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Comment=Dynamic Window Manager" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Exec=~/.dwm/autostart" | sudo tee -a /usr/share/xsessions/dwm.desktop
#else
#  sudo mkdir /usr/share/xsessions
#  sudo touch /usr/share/xsessions/dwm.desktop
#  echo "[Desktop Entry]" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Encoding=UTF-8" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Name=dwm" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Comment=Dynamic Window Manager" | sudo tee -a /usr/share/xsessions/dwm.desktop
#  echo "Exec=~/.dwm/autostart" | sudo tee -a /usr/share/xsessions/dwm.desktop
#fi
#
#printf "\n"
#printf "##########################################\n"
#printf "###### dwm is successfully installed######\n"
#printf "##########################################\n\n"


printf "\n"
printf "############################################\n"
printf "###### Qtile is successfully installed######\n"
printf "############################################\n\n"
