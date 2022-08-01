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

##################################################
###################### AURs ######################
##################################################
## COPY AND RUN ON ANOTHER TERM INSTANCE (TO SAVE TIME) ##
#o
#paru -S --needed spotify spotify-adblock-git visual-studio-code-bin ananicy-cpp
#paru -S --needed android-sdk-platform-tools anydesk-bin caffeine-ng google-earth-pro
#paru -S --needed mailspring masterpdfeditor-free xdman zoom zramd envycontrol dropbox
#paru -S --needed nohang-git auto-cpufreq
#sudo systemctl enable --now zramd.service
#sudo systemctl enable --now ananicy-cpp.service
#sudo systemctl enable --now nohang-desktop.service
#sudo systemctl enable --now systemd-oomd.service
#sudo systemctl enable --now auto-cpufreq.service

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

#####################################################
########### VirtualBox and MORE! Packages ###########
#####################################################
paru -S --needed virtualbox virtualbox-guest-iso zathura zathura-pdf-poppler gcolor2
paru -S --needed virtualbox-ext-oracle fish texlive-most starship ttf-twemoji stow pacman-contrib
paru -S --needed pkgfile dmidecode thunderbird rhythmbox tree
sudo pkgfile --update
chsh -s /usr/bin/fish
paru -S --needed stylua gparted mpv yt-dlp libreoffice-fresh tumbler pcmanfm ffmpegthumbnailer xarchiver exa fzf zoxide ripgrep neovim python-neovim xclip libgnome-keyring python-keyring
paru -S --needed wget telegram-desktop redshift flameshot unzip
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
sudo modprobe vboxdrv
sudo usermod -aG adbusers vboxusers aloks

# Setting thunar as default file manager
xdg-mime default thunar.desktop inode/directory

printf "\n\n"
printf "############################\n"
printf "##### script completed #####\n"
printf "############################\n\n"
