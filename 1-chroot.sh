#!/bin/bash

# Formatting the partitions
mkfs.fat -F32 /dev/nvme0n1p1 -n "EFI"
mkfs.ext4 /dev/nvme0n1p2 -L "Arch"
mkfs.ext4 /dev/nvme0n1p3 -L "Home"

# Mount the partitions
mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/{home,boot/efi}
mount /dev/nvme0n1p1 /mnt/boot/efi
mount /dev/nvme0n1p3 /mnt/home

# pacstrap and chroot
pacstrap -i /mnt base linux linux-headers linux-firmware vim nano intel-ucode git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
