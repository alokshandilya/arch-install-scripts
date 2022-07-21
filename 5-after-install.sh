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
paru -S timeshift timeshift-autosnap spotify spotify-adblock-git visual-studio-code-bin ananicy-cpp android-sdk-platform-tools anydesk-bin caffeine-ng google-earth-pro mailspring masterpdfeditor-free picom-git xdman zoom zramd envycontrol

sudo systemctl enable --now cronie.service
sudo systemctl enable --now zramd.service
sudo systemctl enable --now auto-cpufreq.service
sudo systemctl enable --now ananicy-cpp.service

# Theme [orchis], Icon [Qogir]
printf "#########################################\n"
printf "###### Installing Orchis and Qogir ######\n"
printf "#########################################\n"
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
sudo ./install.sh -t green
cd ..
git clone https://github.com/vinceliuice/Qogir-icon-theme.git
cd Qogir-icon-theme
sudo ./install.sh
cd

# Install Virtualbox
paru -S virtualbox virtualbox-guest-iso virtualbox-ext-oracle
sudo modprobe vboxdrv

# Install some packages and stuff
chsh -s /usr/bin/zsh
paru -S stylua gparted mpv yt-dlp libreoffice-fresh tumbler thunar-volman thunar-archive-plugin exa fzf zoxide ripgrep neovim python-neovim xclip libgnome-keyring python-keyring
paru -S telegram-desktop redshift flameshot unzip
# unzip and wget required for fnm
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
usermod -aG adbusers vboxusers aloks

printf "\n\n"
printf "############################\n"
printf "##### script completed #####\n"
printf "############################\n\n"
