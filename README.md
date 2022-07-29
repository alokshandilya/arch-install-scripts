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

- modify snapper config

```sh
vim /etc/snapper/configs/root
```

- ALLOW\*USERS="xxx" \*\*\*[replace xxx with username]\_\*\*

  - TIMELINE_MIN_AGE="1800"
  - TIMELINE_LIMIT_HOURLY="5"
  - TIMELINE_LIMIT_DAILY="7"
  - TIMELINE_LIMIT_WEEKLY="0"
  - TIMELINE_LIMIT_MONTHLY="0"
  - TIMELINE_LIMIT_YEARLY="0"

- change permissions of `/.snapshots` directory

```sh
chmod a+rx /.snapshots
```

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

7. create first snapshot

```sh
snapper -c root create -c timeline --description firstSnapshot
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
