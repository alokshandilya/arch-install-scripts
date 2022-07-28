#!/bin/bash

##############################
##### Without encryption #####
##############################

#----------------------------------------------------------------------------------------------------------

#####################################
##### Formatting the partitions #####
#####################################
mkfs.fat -F32 /dev/nvme0n1p1 -n "EFI"
mkfs.btrfs -f /dev/nvme0n1p2 -L "BTRFS"
################################
##### Mount the partitions #####
################################
mount /dev/nvme0n1p2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@root
btrfs su cr /mnt/@home
btrfs su cr /mnt/@srv
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@log
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@snapshots
umount /mnt
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@ /dev/nvme0n1p2 /mnt
mkdir -p /mnt/{home,root,boot/efi,var/cache,var/log,var/tmp,srv,.snapshots}
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@root /dev/nvme0n1p2 /mnt/root
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@cache /dev/nvme0n1p2 /mnt/var/cache
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@log /dev/nvme0n1p2 /mnt/var/log
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@tmp /dev/nvme0n1p2 /mnt/var/tmp
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@srv /dev/nvme0n1p2 /mnt/srv
mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots
mount /dev/nvme0n1p1 /mnt/boot/efi
pacstrap -i /mnt base btrfs-progs linux-zen linux-zen-headers linux-firmware vim intel-ucode git snapper
genfstab -U /mnt >> /mnt/etc/fstab
#arch-chroot /mnt

#----------------------------------------------------------------------------------------------------------

###########################
##### With encryption #####
###########################

#----------------------------------------------------------------------------------------------------------

#####################################
##### Formatting the partitions #####
#####################################
#mkfs.fat -F32 /dev/nvme0n1p1 -n "EFI"
#cryptsetup --cipher aes-xts-plain64 --hash sha512 --use-random --verify-passphrase luksFormat /dev/nvme0n1p2
#cryptsetup luksOpen /dev/nvme0n1p2 root
#mkfs.btrfs -f /dev/mapper/root
################################
##### Mount the partitions #####
################################
#mount /dev/mapper/root /mnt
#btrfs su cr /mnt/@
#btrfs su cr /mnt/@root
#btrfs su cr /mnt/@home
#btrfs su cr /mnt/@srv
#btrfs su cr /mnt/@cache
#btrfs su cr /mnt/@log
#btrfs su cr /mnt/@tmp
#btrfs su cr /mnt/@snapshots
#umount /mnt
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@ /dev/mapper/root /mnt
#mkdir -p /mnt/{home,root,boot/efi,var/cache,var/log,var/tmp,srv,.snapshots}
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@root /dev/mapper/root /mnt/root
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@home /dev/mapper/root /mnt/home
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@cache /dev/mapper/root /mnt/var/cache
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@log /dev/mapper/root /mnt/var/log
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@tmp /dev/mapper/root /mnt/var/tmp
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@srv /dev/mapper/root /mnt/srv
#mount -o defaults,noatime,compress=zstd,discard=async,space_cache=v2,autodefrag,subvol=@snapshots /dev/mapper/root /mnt/.snapshots
#mount /dev/nvme0n1p1 /mnt/boot/efi
#pacstrap -i /mnt base btrfs-progs linux-zen linux-zen-headers linux-firmware vim intel-ucode git snapper
#genfstab -U /mnt >> /mnt/etc/fstab
##arch-chroot /mnt
