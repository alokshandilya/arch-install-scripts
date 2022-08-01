#!/bin/bash

#------------#-------------#
# Subvolume  # Mountpoint  #
#------------#-------------#
# @          # /           #
# @home      # /home       #
# @snapshots # /.snapshots #
# @var_log   # /var/log    #
#------------#-------------#

mkfs.fat -F32 /dev/nvme0n1p1 -n "EFI"
mkfs.btrfs -f /dev/nvme0n1p2 -L "BTRFS"

mount /dev/nvme0n1p2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@var_log

umount /mnt

mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@ /dev/nvme0n1p2 /mnt
mkdir -p /mnt/{home,boot/efi,var/log,.snapshots}
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@var_log /dev/nvme0n1p2 /mnt/var/log
mount /dev/nvme0n1p1 /mnt/boot/efi

pacstrap -i /mnt base btrfs-progs linux-zen linux-zen-headers linux-firmware vim intel-ucode git snapper
genfstab -U /mnt >> /mnt/etc/fstab
#arch-chroot /mnt
