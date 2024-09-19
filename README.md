# Steps

## Boot to ISO and check Networking

I usually set bigger font with `setfont ter-132n` & connect to _WiFi_ :

- `iwctl`
- `device list`
- `station wlan0 get-networks` _(it's wlan0 in my case)_
- `station wlan0 connect "xxx"`
- `ip a`
- `ping www.archlinux.org`

> connecting with Ethernet or mobile USB tethering is enabled by **_default_**

### Update system clock

- `timedatectl set-ntp true`, check with `timedatectl status`

## Partition the disk(s)

I install Arch on my ~233G SSD.

| _nvme0n1_ | _fstype_ | _size_ | _mount point_                                                  | _Label_ |
| --------- | -------- | ------ | -------------------------------------------------------------- | ------- |
| nvme0n1p1 | fat32    | 550M   | /boot/efi                                                      | EFI     |
| nvme0n1p2 | btrfs    | 232G   | /<br>/home<br>/var/log<br>/.snapshots<br>/var/cache/pacman/pkg | BTRFS   |

- `nvme0n1p2` remaining size. **_~232G_**
  > later set up `zram`

## Format and Mount the partitions

uncomment `ParallelDownloads` in `/etc/pacman.conf` and install _git_

```sh
pacman -Sy git archlinux-keyring
```

- if mirrors are slow `reflector -c India -f 5 -l 5 --sort rate --verbose --save /etc/pacman.d/mirrorlist`

```sh
git clone https://github.com/alokshandilya/arch-install-scripts.git
```

all scripts are executable but still have a glance on the commands and **modify** accordingly

```sh
./1-chroot.sh
```

- run 🏃`./1-chroot.sh`
  - formats the partitions
  - makes btrfs subvolumes
  - mounts the partitions
  - pacstraps base, kernel etc to `/mnt`
  - generates fstab based on UUIDs _(remove subvolid later from `/etc/fstab`)_

```sh
arch-chroot /mnt
```

## Install Arch Linux

- in `/etc/pacman.conf`
  - uncomment `ParallelDownloads`
  - add `ILoveCandy`
  - enable `multilib` repository
- Delete `subvolid` from `/etc/fstab`
- vim `/etc/locale.gen` and uncomment `en_IN` and `en_US` **UTF-8**
- `locale-gen`
- change password in `2-base-install.sh`
- run 🏃`2-base-install.sh`

```sh
./2-base-install.sh
```

- edit `/etc/default/grub`
  - `blkid > blkit.txt` _:vs_ _:bp_ _:bn_ in vim `/etc/default/grub`
    - note `nvme0n1p2` _(partition with subvolumes)_ UUID
  - `GRUB_CMDLINE_LINUX=cryptdevice=UUID=xxxxx:cryptroot rootfstype=btrfs`
  - `grub-mkconfig -o /boot/grub/grub.cfg`

> run 🏃 `3-touchpad.sh` if to use Window Manager (on laptop) to enable trackpad reverse scrolling etc.

- edit `/etc/mkinitcpio.conf`
  - `MODULES=(btrfs crc32c-intel intel_agp i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)`
  - `HOOKS=(.... encrypt filesystems fsck)`
- `mkinitcpio -P`
- do `exit` , `umount -a` , `reboot`

## Post Installation

- connect to wifi with `nmtui`

### Install DWM :robot:

```sh
./4-dwm-install.sh
```
- `COMPRESSZST=(zstd -c -T0 --auto-threads=logical --adapt --exclude-compressed -)`
  - in `/etc/makepkg.conf` to reduce compression time while building AURs
- uncomment `BottomUp` and `NewsOnUpgrade` in `/etc/paru.conf`
- reboot
- run 🏃`5-packages-AUR.sh`
  - AURs are commented
- install rest of the packages

```sh
cd ~/arch-install-scripts
paru -S stow
paru -S --needed - < pkglist.txt
```

#### Dotfiles :star2:

- `4-dwm-install` script also installs paru

```sh
git clone https://github.com/alokshandilya/dotfiles.git
git clone https://github.com/alokshandilya/nvim.git ~/.config/nvim
cd dotfiles
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/bin/scripts
mkdir -p ~/.local/bin/dwmblocks
stow .
```

### Reduce Swappiness

```sh
su -
touch /etc/sysctl.d/99-swappiness.conf
echo "vm.swappiness=1" >> /etc/sysctl.d/99-swappiness.conf
```

- reboot

## Also

- edit `/etc/locale.gen` and uncomment `en_IN` and `en_US` _(default by archinstall)_ **UTF-8**
- delete `subvolid` from `/etc/fstab`
- [DRM Kernel Mode Setting](https://wiki.archlinux.org/title/NVIDIA#DRM_kernel_mode_setting)
- [Gnome Keyring](https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring)
  - logout, login and check **Login** is unlocked through _seahorse_
  - if using `vscode` then, configure runtime arguments
    - `password-store` as `gnome`
    - `disable-hardware-acceleration` as `true`
- setup [snapper](SNAPPER.md)
- postgreSQL setup
  - `paru -S postgresql`
  - `sudo -iu postgres`
  - `initdb -D /var/lib/postgres/data`
  - `exit`
  - `sudo chattr +C /var/lib/postgres/data`
  - `sudo systemctl enable --now postgresql`
  - `sudo -iu postgres`
  - `createuser --interactive`
  - `createdb $USER`
  - `exit`
  - [pgadmin4](https://www.pgadmin.org/download/pgadmin-4-python/)
