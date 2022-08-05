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

# =====================================================================================================================================
# =========================== ENCRYPTION ==============================================================================================
# =====================================================================================================================================
#
#-------------#-----------------------#
# Subvolume   # Mountpoint            #
#-------------#-----------------------#
# @           # /                     #
# @home       # /home                 #
# @.snapshots # /.snapshots           #
# @pkg        # /var/cache/pacman/pkg #
# @log        # /var/log              #
#-------------#-----------------------#
#
# mkfs.fat -F32 /dev/nvme0n1p1 -n "EFI"
# cryptsetup --cipher aes-xts-plain64 --hash sha512 --use-random --verify-passphrase luksFormat /dev/nvme0n1p2
# cryptsetup luksOpen /dev/nvme0n1p2 cryptroot
# mkfs.btrfs -f /dev/mapper/cryptroot -L "BTRFS"
#
# mount /dev/mapper/cryptroot /mnt
# btrfs su cr /mnt/@
# btrfs su cr /mnt/@home
# btrfs su cr /mnt/@.snapshots
# btrfs su cr /mnt/@pkg
# btrfs su cr /mnt/@log
#
# umount /mnt
#
# mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@ /dev/mapper/cryptroot /mnt
# mkdir -p /mnt/{home,boot/efi,var/cache/pacman/pkg,var/log,.snapshots}
# mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@home /dev/mapper/cryptroot /mnt/home
# mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@.snapshots /dev/mapper/cryptroot /mnt/.snapshots
# mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@pkg /dev/mapper/cryptroot /mnt/var/cache/pacman/pkg
# mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@log /dev/mapper/cryptroot /mnt/var/log
# mount /dev/nvme0n1p1 /mnt/boot/efi
#
# pacstrap -i /mnt base btrfs-progs linux-zen linux-zen-headers linux-firmware vim intel-ucode git snapper
# genfstab -U /mnt >> /mnt/etc/fstab
# #arch-chroot /mnt
