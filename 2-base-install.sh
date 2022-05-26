#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "alokpc" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 alokpc.localdomain alokpc" >> /etc/hosts

# change password
echo root:password| chpasswd

# chooose grub to grub-btrfs [for BTRFS]
pacman -Syy
pacman -S grub grub-btrfs efibootmgr networkmanager network-manager-applet xorg mesa zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting firefox ttc-iosevka python-pip python-pillow github-cli hub ttf-jetbrains-mono ttf-cascadia-code noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-font-awesome ttf-ibm-plex ttf-joypixels ttf-liberation ttf-opensans dialog wpa_supplicant mtools dosfstools reflector base-devel avahi xdg-user-dirs xdg-user-dirs-gtk xdg-utils gvfs gvfs-smb gvfs-mtp nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pulseaudio pulseaudio-alsa pavucontrol bash-completion openssh rsync reflector acpi virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font android-udev


# LTS or Normal
# pacman -S acpi_call-lts nvidia-lts
pacman -S acpi_call nvidia

pacman -S intel-gmmlib intel-media-driver vulkan-headers vulkan-icd-loader vulkan-intel vulkan-mesa-layers vulkan-radeon vulkan-swrast vulkan-tools mesa mesa-demos mesa-utils mesa-vdpau lib32-brotli lib32-libice lib32-libxcrypt lib32-mesa-vdpau lib32-bzip2 lib32-libidn2 lib32-libxdamage lib32-ncurses lib32-curl lib32-libldap lib32-libxdmcp lib32-nvidia-utils lib32-e2fsprogs lib32-libpciaccess lib32-libxext lib32-ocl-icd lib32-expat lib32-libpsl lib32-libxfixes lib32-opencl-nvidia lib32-freeglut lib32-libsm lib32-libxi lib32-openssl lib32-gcc-libs lib32-libssh2 lib32-libxml2 lib32-readline lib32-glew lib32-libunistring lib32-libxmu lib32-util-linux lib32-glibc lib32-libunwind lib32-libxrandr lib32-vulkan-icd-loader lib32-glu lib32-libva lib32-libxrender lib32-vulkan-intel lib32-icu lib32-libva-intel-driver lib32-libxshmfence lib32-vulkan-mesa-layers
pacman -S lib32-keyutils lib32-libva-mesa-driver lib32-libxt lib32-vulkan-radeon lib32-krb5 lib32-libva-vdpau-driver lib32-libxxf86vm lib32-wayland lib32-libdrm lib32-libvdpau lib32-llvm-libs lib32-xz lib32-libelf lib32-libx11 lib32-lm_sensors lib32-zlib lib32-libffi lib32-libxau lib32-mesa lib32-zstd lib32-libglvnd lib32-libxcb lib32-mesa-demos
# pacman -S --noconfirm xf86-video-intel
pacman -S --noconfirm nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
systemctl enable systemd-resolved.service

useradd -m aloks

# change password
echo aloks:password| chpasswd
usermod -aG libvirt,audio,video aloks

echo "aloks ALL=(ALL) ALL" >> /etc/sudoers.d/aloks

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
