#!/bin/bash

# Install paru-bin (AUR Helper)
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
cd

# Install AUR's
paru -S timeshift timeshift-autosnap spotify spotify-adblock-git jdk visual-studio-code-bin ananicy-cpp auto-cpufreq android-adk-platform-tools anydesk-bin brave-bin caffeine-ng github-desktop-bin google-chrome google-earth-pro google-java-format humanity-icon-theme mailspring masterpdfeditor-free optimus-manager optimus-manger-qt picom-git xcursor-human xdman zoom zramd


sudo systemctl enable --now cronie.service
sudo systemctl enable --now zramd.service
sudo systemctl enable --now auto-cpufreq.service
sudo systemctl enable --now ananicy-cpp.service

# Install Virtualbox
paru -S virtualbox virtualbox-guest-iso virtualbox-ext-oracle
sudo modprobe vboxdrv

# Install some packages and stuff
pip install black
chsh -s /usr/bin/zsh
paru -S stylua intellij-idea-community-edition pycharm-community-edition gparted mpv yt-dlp libreoffice-fresh 
usermod -aG adbusers vboxusers aloks