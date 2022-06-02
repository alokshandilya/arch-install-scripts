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
paru -S timeshift timeshift-autosnap spotify spotify-adblock-git jdk visual-studio-code-bin ananicy-cpp auto-cpufreq android-sdk-platform-tools anydesk-bin brave-bin caffeine-ng github-desktop-bin google-chrome google-earth-pro google-java-format mailspring masterpdfeditor-free optimus-manager optimus-manager-qt picom-git xdman zoom zramd

sudo systemctl enable --now cronie.service
sudo systemctl enable --now zramd.service
sudo systemctl enable --now auto-cpufreq.service
sudo systemctl enable --now ananicy-cpp.service

# Install Virtualbox and Emacs
paru -S virtualbox virtualbox-guest-iso virtualbox-ext-oracle emacs
sudo modprobe vboxdrv

# Install some packages and stuff
pip install black
chsh -s /usr/bin/zsh
paru -S stylua intellij-idea-community-edition pycharm-community-edition gparted mpv yt-dlp libreoffice-fresh tumbler thunar-volman thunar-archive-plugin exa fzf zoxide ripgrep neovim python-neovim xclip libgnome-keyring python-keyring
paru -S telegram-desktop redshift flameshot
curl -fsSL https://fnm.vercel.app/install | bash
usermod -aG adbusers vboxusers aloks

printf "\n\n#################################\n"
printf "##### Installing Doom Emacs #####\n"
printf "#################################\n\n"

mkdir doom-emacs-install-script
cd doom-emacs-install-script
git clone https://github.com/alokshandilya/dotfiles.git
cp -r dotfiles/.config/doom ~/.config/
cd
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
cd
killall emacs
/usr/bin/emacs --daemon

printf "\n\n#######################################\n"
printf "##### Doom Emacs script completed #####\n"
printf "#######################################\n\n"
