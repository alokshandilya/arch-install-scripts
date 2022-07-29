# Arch-install-scripts
My personal scripts for installing arch linux.

## Setting up Snapper

- change to root user

```sh
su -
```

- unmount and remove `/.snapshots` directory

```sh
umount /.snapshots
```

```sh
rm -rf /.snapshots
```

- create snapper config

```sh
snapper -c root create-config /
```

- remove extra snapshot subvol

```sh
btrfs subvol del /.snapshots
```

- re-create `/.snapshots`

```sh
mkdir /.snapshots
```

- mount `/.snapshots` it should be in `/etc/fstab` already

```sh
mount -a
```

- change permission

```sh
chmod 750 /.snapshots
```

```sh
chmod a+rx /.snapshots
```

```sh
chown :aloks /.snapshots
```

> Replace `aloks` with username

- modify snapper config

```sh
vim /etc/snapper/configs/root
```

- ALLOW_USERS="xxx" _[replace xxx with username]_
  - TIMELINE_MIN_AGE="1800"
  - TIMELINE_LIMIT_HOURLY="5"
  - TIMELINE_LIMIT_DAILY="7"
  - TIMELINE_LIMIT_WEEKLY="0"
  - TIMELINE_LIMIT_MONTHLY="0"
  - TIMELINE_LIMIT_YEARLY="0"

- enable and start services
  - `systemctl enable snapper-timeline.timer`
  - `systemctl start snapper-timeline.timer`
  - `systemctl enable snapper-cleanup.timer`
  - `systemctl start snapper-cleanup.timer`
  - `systemctl enable grub-btrfs.path`
  - `systemctl start grub-btrfs.path`
    - snapshot will directly be added to grub bootloader list
- `snapper -c root list`
  - `0` is current system

- create first snapshot

- install 

```sh
paru -S snap-pac-grub snapper-gui snap-pac rsync
```
- create pacman hook `/etc/pacman.d/hooks/95-bootbackup.hook`

```sh
[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Path
Target = usr/lib/modules/*/vmlinuz

[Action]
Depends = rsync
Description = Backing up /boot...
When = PostTransaction
Exec = /usr/bin/rsync -a --delete /boot /.bootbackup
``````

```sh
snapper -c root create -c timeline -d "first snapshot"
```

- `snapper -c root list`
  - `1` is the firstSnapshot
  - check snapshot entry in grub _[read-only]_

## Restoring with Arch-Live-ISO

- `mount /dev/nvme0n1p2 /mnt`
  - here nvme0n1p2 is the partition with btrfs subvolumes
- `cd /mnt/@snapshots`
  - choose snapshot number _(remember)_
  - check `info.xml`
  - check <description>
- `rm -rf /mnt/@`
  - wait
- `btrfs subvol snapshot /mnt/@snapshots/xxx/snapshot /mnt/@`
  - here xxx $\implies$ snapshot number _[1,2,3...]_
- `reboot`
