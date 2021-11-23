#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
sed -i '168s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "alokpc" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 alokpc.localdomain alokpc" >> /etc/hosts

# change password
echo root:password| chpasswd

pacman -S grub efibootmgr networkmanager network-manager-applet xorg mesa kitty firefox picom pcmanfm gnome-keyring polkit-gnome lxappearance numlockx copyq conky feh bpytop ranger dunst arc-gtk-theme arc-icon-theme ttf-jetbrains-mono ttf-cascadia-code noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid ttf-font-awesome ttf-ibm-plex ttf-joypixels ttf-liberation ttf-opensans dialog wpa_supplicant mtools dosfstools reflector base-devel avahi xdg-user-dirs xdg-utils gvfs gvfs-smb gvfs-mtp nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pulseaudio pulseaudio-alsa pavucontrol bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

pacman -S --noconfirm xf86-video-intel
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp
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
