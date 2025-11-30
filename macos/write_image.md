# Write image file to disk using dd

```bash
diskutil list
diskutil unmountDisk /dev/diskN

sudo dd bs=1M if=./image.img of=/dev/rdiskN conv=sync
```

## Create Image

```bash
diskutil list
diskutil unmountDisk /dev/diskN

sudo dd bs=1M if=/dev/rdiskN of=./image.img
```
