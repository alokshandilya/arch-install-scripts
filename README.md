# Using `archinstall` script

This is how I set up my Arch Linux system using `archinstall` script.

> **Note:** I use Arch BTW 🗿

- check [main](https://github.com/alokshandilya/arch-install-scripts/tree/main) branch if don't want to use _archinstall_ script

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

## Install Arch Linux

- in `/etc/pacman.conf`
  - uncomment **_ParallelDownloads_**
  - add **_ILoveCandy_**
  - enable **_multilib_** repository

```sh
pacman -Syy
pacman -S archinstall neovim archlinux-keyring
archinstall # with btrfs, qtile
reboot
```

# After Install

```sh
cd ~
git clone https://github.com/alokshandilya/arch-install-scripts.git
cd arch-install-scripts
./0-arch-install-script.sh # run in parts after checking in neovim term
```

- switch to qtile (wayland)
- edit _/usr/share/wayland-sessions/qtile-wayland.desktop_
  - `Exec=/home/aloks/.local/bin/./wayland-start.sh`
- edit _/etc/mkinitcpio.conf_
  - `MODULES=(btrfs crc32c-intel intel_agp i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)`
  - `HOOKS=(.... encrypt filesystems fsck)` _(if using encryption)_

```sh
mkinitcpio -P
```

- edit _/etc/makepkg.conf_ to reduce compression time while building AURs
  - `COMPRESSZST=(zstd -c -T0 --auto-threads=logical --adapt --exclude-compressed -)`
- uncomment `BottomUp` and `NewsOnUpgrade` in `/etc/paru.conf`
- reboot

### Install packages from `pkglist.txt`

```sh
cd ~/arch-install-scripts
paru -S --needed - < pkglist.txt
```

### Reduce Swappiness

```sh
su -
touch /etc/sysctl.d/99-swappiness.conf
echo "vm.swappiness=1" >> /etc/sysctl.d/99-swappiness.conf
```

## Also

- edit `/etc/locale.gen` and uncomment `en_IN` and `en_US` _(default by archinstall)_ **UTF-8**
- delete `subvolid` from `/etc/fstab`
- [DRM Kernel Mode Setting](https://wiki.archlinux.org/title/NVIDIA#DRM_kernel_mode_setting)
  - `sudo vim /etc/modprobe.d/nvidia_drm.conf`
    - `options nvidia_drm modeset=1`
- [Gnome Keyring](https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring)
- `shutdown -h now`
  - if using `vscode` then, configure runtime arguments
    - `password-store` as `gnome`
    - `disable-hardware-acceleration` as `true`
- `gh auth login` to authenticate with GitHub after checking `login` keyring in `seahorse`
  - `:Copilot signin` for neovim copilot
- setup [snapper](SNAPPER.md)
- postgreSQL setup
  - `sudo pacman -S postgresql`
  - `sudo -iu postgres`
  - `initdb -D /var/lib/postgres/data`
  - `sudo chattr +C /var/lib/postgres/data`
  - `sudo systemctl enable --now postgresql`
  - `exit`
  - `sudo -iu postgres`
  - `createuser --interactive`
  - `createdb $USER`
  - `exit`
  - [pgadmin4](https://www.pgadmin.org/download/pgadmin-4-python/)
