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
