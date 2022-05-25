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
printf "############################\n"
printf "##### Installing Fonts #####\n"
printf "############################\n\n"
paru -S bat nerd-fonts-jetbrains-mono ttf-fira-code nerd-fonts-fira-code

printf "\n"
printf "#################################\n"
printf "##### Installing KDE Plasma #####\n"
printf "#################################\n\n"
paru -S plasma-meta plasma-wayland-session kde-applications-meta sddm kdenlive kdeconnect

printf "\n"
printf "#########################\n"
printf "##### Enabling SDDM #####\n"
printf "#########################\n\n"
sudo systemctl enable sddm
