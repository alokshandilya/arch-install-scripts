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

#######################################
##### Theme[Orchis], Icons[Qogir] #####
#######################################
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

##################################################
###################### AURs ######################
##################################################
# COPY AND RUN ON ANOTHER TERM INSTANCE (TO SAVE TIME)
#
#paru -S --needed spotify spotify-adblock-git visual-studio-code-bin ananicy-cpp
#paru -S --needed android-sdk-platform-tools anydesk-bin caffeine-ng google-earth-pro
#paru -S --needed mailspring masterpdfeditor-free xdman zoom zramd envycontrol dropbox
#paru -S --needed nohang-git auto-cpufreq appimagelauncher xbanish betterlockscreen
#paru -S --needed downgrade rar pandoc-bin ttf-cascadia-code-nerd
#sudo systemctl enable --now zramd.service
#sudo systemctl enable --now ananicy-cpp.service
#sudo systemctl enable --now nohang-desktop.service
#sudo systemctl enable --now systemd-oomd.service
#sudo systemctl enable --now auto-cpufreq.service

########################################################
########### VirtualBox, fish, startship, fnm ###########
########################################################
paru -S --needed virtualbox virtualbox-guest-iso pkgfile unzip wget
paru -S --needed virtualbox-ext-oracle fish starship ttf-twemoji ttf-twemoji-color
sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf
sudo ln -sf /usr/share/fontconfig/conf.avail/46-ttf-twemoji-color.conf /etc/fonts/conf.d/46-ttf-twemoji-color.conf
sudo pkgfile --update
chsh -s /usr/bin/fish
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
sudo modprobe vboxdrv
sudo usermod -aG adbusers,vboxusers,kvm aloks
# Setting pcmanfm as default file manager
xdg-mime default pcmanfm.desktop inode/directory

printf "\n\n"
printf "############################\n"
printf "##### script completed #####\n"
printf "############################\n\n"
