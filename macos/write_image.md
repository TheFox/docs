# Write image file to disk using dd

```bash
diskutil list
sudo dd bs=1m if=./image.img of=/dev/rdiskN conv=sync
```
