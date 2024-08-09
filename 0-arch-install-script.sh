#!/bin/bash

##########################
######## SECTIONS ######## 
##########################
# 1. Core
# 2. Basic
# 3. Fonts
# 4. AUR Helper
# 5. Themes, Icons
# 6. Neovim config

####################
###### 1.Core ######
####################
sudo pacman -S --needed btrfs-progs linux-zen-headers linux-firmware vim intel-ucode snapper archlinux-keyring 
sudo pacman -S --needed wpa_supplicant mtools dosfstools base-devel avahi xdg-user-dirs xdg-user-dirs-gtk
sudo pacman -S --needed xdg-utils gvfs gvfs-smb gvfs-mtp nfs-utils inetutils dnsutils bluez bluez-utils blueman cups
sudo pacman -S --needed alsa-utils pipewire pipewire-alsa pipewire-pulse pavucontrol bash-completion openssh rsync reflector
sudo pacman -S --needed acpi virt-manager qemu qemu-full edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset
sudo pacman -S --needed flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font android-udev ufw gufw
# sudo ufw default deny
# sudo ufw allow from 192.168.0.0/24
# sudo ufw allow Deluge
# sudo ufw limit ssh
# sudo ufw enable


#####################
###### 2.Basic ######
#####################
sudo pacman -S --needed stow neovim git vim firefox wget zsh dash bat pkgfile thunderbird
sudo pacman -S --needed fzf zoxide unzip unrar bc sysstat tk less ripgrep pyenv python-pipx
sudo pacman -S --needed nvidia-dkms acpi_call-dkms nvidia-utils nvidia-settings brightnessctl

# sudo systemctl enable NetworkManager
# sudo systemctl enable ufw.service
# sudo systemctl enable bluetooth.service
# sudo systemctl enable cups.service
# sudo systemctl enable sshd
# sudo systemctl enable avahi-daemon
# sudo systemctl enable reflector.timer
# sudo systemctl enable fstrim.timer
# sudo systemctl enable libvirtd
# sudo systemctl enable acpid
# sudo systemctl enable systemd-resolved.service
# sudo usermod -aG libvirt,audio,video aloks

#####################
###### 3.Fonts ######
#####################
# win fonts from iso
sudo pacman -S --needed ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-jetbrains-mono

##################################
###### 4.Paru (AUR helper ) ######
##################################
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

##############################
###### 5. Themes, Icons ######
##############################
#git clone https://github.com/vinceliuice/Orchis-theme.git
#cd Orchis-theme
#sudo ./install.sh -t green
#cd ..
#git clone https://github.com/vinceliuice/Qogir-icon-theme.git
#cd Qogir-icon-theme
#sudo ./install.sh
#cd

###################################################
###################### QTILE ######################
###################################################
sudo pacman -S --needed python-xdg python-pywlroots python-dbus-next python-iwlib xorg-xwayland python-setproctitle wl-clipboard
sudo pacman -S --needed jupyter_console khal nwg-look polkit-gnome gnome-keyring grim kvantum-theme-materia kvantum-qt5 swww bpytop ranger rofi-wayland exa
sudo pacman -S --needed qt5ct qt6ct dunst ffmpegthumbnailer xarchiver gammastep xdg-desktop-portal xdg-desktop-portal-wlr
sudo pacman -S --needed thunar thunar-volman tumbler catfish thunar-archive-plugin thunar-media-tags-plugin poppler-glib libgsf libgepub libopenraw mlocate
#mv ~/.config/qtile ~/.config/qtile.bak
#git clone https://github.com/alokshandilya/qtile.git ~/.config/qtile
#mkdir -p ~/.config/alacritty/themes
#git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

#################################################
###################### GIT ######################
#################################################
#git config --global init.defaultBranch main
#git config --global core.editor nvim
#git config --global user.name alokshandilya
#git config --global user.email alok.shandilya10@gmail.com

######################################################
###################### DOTFILES ######################
######################################################
#git clone https://github.com/alokshandilya/dotfiles.git ~/dotfiles
#cd ~/dotfiles
#mkdir -p ~/.local/share/applications
#mkdir -p ~/.local/bin/scripts
#mkdir -p ~/.local/bin/dwmblocks
#stow .

##################################################
###################### AURs ######################
##################################################
# COPY AND RUN ON ANOTHER TERM INSTANCE (TO SAVE TIME)
#
#paru -S --needed spotify spotify-adblock-git visual-studio-code-bin ananicy-cpp
#paru -S --needed android-sdk-platform-tools anydesk-bin caffeine-ng google-earth-pro
#paru -S --needed mailspring masterpdfeditor-free xdman zoom zramd envycontrol dropbox
#paru -S --needed nohang-git auto-cpufreq appimagelauncher xbanish betterlockscreen
#paru -S --needed downgrade pandoc-bin ttf-cascadia-code-nerd

#sudo usermod -aG adbusers, kvm aloks
#sudo systemctl enable --now zramd.service
#sudo systemctl enable --now ananicy-cpp.service
#sudo systemctl enable --now nohang-desktop.service
#sudo systemctl enable --now systemd-oomd.service
#sudo systemctl enable --now auto-cpufreq.service

###############################################
########### zsh, fnm, docker, pyenv ###########
###############################################
### paru -S --needed pkgfile unzip wget unrar bc sysstat tk
### #paru -S --needed tidy python-pipenv python-isort shellcheck stylelint python-pipx glow
### paru -S --needed starship ttf-twemoji docker docker-buildx
### sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf
### sudo systemctl enable docker.socket
### sudo usermod -aG docker aloks
### sudo pkgfile --update
### 
### chsh -s /usr/bin/zsh
### zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
### curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
### pyenv install 3.12.0


################################################
########### lvim, doom emacs, vscode ###########
################################################
#pyenv global 3.12.0
#pip install black pyflakes isort pipenv nose pytest
sudo pacman -S --needed lazygit git make cargo ripgrep emacs

#LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

#git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
#~/.config/emacs/bin/doom install

### #npm i -g js-beautify markdownlint
