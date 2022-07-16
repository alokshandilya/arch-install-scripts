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

# Install AUR's
paru -S timeshift visual-studio-code-bin ananicy-cpp android-sdk-platform-tools anydesk-bin caffeine-ng google-earth-pro masterpdfeditor-free xdman zoom zramd
paru -S qogir-icon-theme-git qogir-gtk-theme-git kvantum-theme-qogir-git

sudo systemctl enable --now cronie.service
sudo systemctl enable --now zramd.service
sudo systemctl enable --now ananicy-cpp.service

# Install Virtualbox and Emacs
paru -S virtualbox virtualbox-guest-iso virtualbox-ext-oracle emacs
sudo modprobe vboxdrv

# Install some packages and stuff
pip install black
chsh -s /usr/bin/zsh
paru -S stylua gparted mpv yt-dlp libreoffice-fresh tumbler ffmpegthumbnailer thunar-volman thunar-archive-plugin exa fzf zoxide ripgrep neovim xclip libgnome-keyring python-keyring
paru -S telegram-desktop redshift flameshot
curl -fsSL https://fnm.vercel.app/install | bash
usermod -aG adbusers vboxusers aloks
