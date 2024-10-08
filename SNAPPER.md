# Setting up Snapper

- change to root user

```sh
su -
# unmount and remove /.snapshots directory
umount /.snapshots
rm -r /.snapshots
snapper -c root create-config /  # create snapper config
btrfs subvol del /.snapshots  # remove extra snapshot subvolume
mkdir /.snapshots
mount -a  # mount /.snapshots, it should be in /etc/fstab already
chmod 750 /.snapshots
chmod a+rx /.snapshots
chown :$USER /.snapshots
```

- modify snapper config

```sh
vim /etc/snapper/configs/root
```

- `ALLOW_USERS="aloks"`

  > replace `aloks` with username

  - `TIMELINE_MIN_AGE="1800"`
  - `TIMELINE_LIMIT_HOURLY="5"`
  - `TIMELINE_LIMIT_DAILY="7"`
  - `TIMELINE_LIMIT_WEEKLY="0"`
  - `TIMELINE_LIMIT_MONTHLY="0"`
  - `TIMELINE_LIMIT_YEARLY="0"`

- enable and start services
  - `systemctl enable --now snapper-timeline.timer`
  - `systemctl enable --now snapper-cleanup.timer`
  - `systemctl enable --now grub-btrfsd.service`  _(if using grub)_
    - snapshot will directly be added to grub bootloader list
- `snapper -c root list`

  - `0` is current system

- install

```sh
paru -S --needed snap-pac rsync
paru -S --needed snap-pac-grub  # if using grub
paru -S --needed snapper-gui  # optional
```

- `sudo mkdir /etc/pacman.d/hooks`
- `sudo vim /etc/pacman.d/hooks/95-bootbackup.hook`

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
```

- create first snapshot

```sh
snapper -c root create -c timeline -d "first snapshot"
```

- `snapper -c root list`
  - `1` is the firstSnapshot
  - check snapshot entry in grub _[read-only]_

## Restoring with Arch-Live-ISO

- `mount /dev/nvme0n1p2 /mnt`
  - here nvme0n1p2 is the partition with btrfs subvolumes
  - check subvolumes `ls /mnt`
- find the number of the snapshot you want to recover
  - `grep -r '<date>' /mnt/@snapshots/*/info.xml`
  - `grep -r '<description>' /mnt/@snapshots/*/info.xml`
- `mv /mnt/@ /mnt/@.broken` _OR_ `rm -rf /mnt/@`
  - removing can take 5-10 sec
- <pre>btrfs subvol snapshot /mnt/@snapshots/<i><b>NUM</b></i>/snapshot /mnt/@</pre>
  - here `NUM` is snapshot number
- `reboot`
