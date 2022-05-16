#!/bin/bash
mkfs.vfat /dev/nvme0n1p1 -n "EFI"
mkfs.btrfs /dev/nvme0n1p2 -L "BTRFS"

# Mount the partitions
mount /dev/nvme0n1p2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@cache
btrfs su cr /mnt@log
umount /mnt
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@ /dev/nvme0n1p2 /mnt
mkdir -p /mnt/{home,boot/efi,var/cache,var/log}
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@cache /dev/nvme0n1p2 /mnt/var/cache
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@log /dev/nvme0n1p2 /mnt/var/log
mount /dev/nvme0n1p1 /mnt/boot/efi

# Install Arch Linux
reflector -c India --sort rate --verbose --save /etc/pacman.d/mirrorlist
pacstrap -i /mnt base btrfs-progs linux linux-headers linux-firmware vim nano intel-ucode git
genfstab -U /mnt >> /mnt/etc/fstab
#arch-chroot /mnt