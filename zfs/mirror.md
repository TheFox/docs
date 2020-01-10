# ZFS Mirror da1 to da2

Link: <https://blog.fosketts.net/2017/12/11/add-mirror-existing-zfs-drive/>

## Status

```bash
zpool status POOL_NAME
```

## Show da2 Info

```bash
gpart list da2
```

## Delete original partitions

```bash
gpart destroy -F /dev/da2
```

## Format drive

```bash
gpart create -s gpt /dev/da2
```

## Create partition

```bash
gpart add -t freebsd-zfs /dev/da2
```

## Attach

```bash
zpool attach POOL_NAME /dev/gptid/<DA1_ID> /dev/gptid/<DA2_ID>
```
