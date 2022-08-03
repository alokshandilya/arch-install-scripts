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

pacman -Syy
pacman -S --needed grub grub-btrfs efibootmgr networkmanager network-manager-applet xorg mesa firefox dialog
pacman -S --needed wpa_supplicant mtools dosfstools reflector base-devel avahi xdg-user-dirs xdg-user-dirs-gtk
pacman -S --needed xdg-utils gvfs gvfs-smb gvfs-mtp nfs-utils inetutils dnsutils bluez bluez-utils cups hplip
pacman -S --needed alsa-utils pipewire pipewire-alsa pipewire-pulse pavucontrol bash-completion openssh rsync reflector
pacman -S --needed acpi virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset
pacman -S --needed flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font android-udev
pacman -S --needed ufw gufw

ufw default deny
ufw allow from 192.168.0.0/24
ufw allow Deluge
ufw limit ssh
ufw enable

# pacman -S acpi_call-lts nvidia-lts
# pacman -S acpi_call nvidia
pacman -S acpi_call-dkms nvidia-dkms

pacman -S --needed nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable ufw.service
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable acpid
systemctl enable systemd-resolved.service

useradd -m aloks

# change password
echo aloks:password| chpasswd
usermod -aG libvirt,audio,video aloks

echo "aloks ALL=(ALL) ALL" >> /etc/sudoers.d/aloks

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
