#!/bin/bash

# Install paru-bin (AUR Helper)
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
cd

paru -S bat nerd-fonts-jetbrains-mono ttf-fira-code nerd-fonts-fira-code
paru -S plasma plasma-wayland-session kde-applications sddm kdenlive kdeconnect

sudo systemctl enable sddm