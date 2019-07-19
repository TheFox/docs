# macOS IPv6 Commands

- Commands with a `$` at the beginning can be run as normal user.
- Commands with a `#` at the beginning must be run as root user.
- In this examples I assume your IPv6 address of `en0` interface is `2001:beef::2` and the default gateway is `2001:beef::1`.

### Manual Page

```
$ man route
```

### Flush

```
# route flush -inet6
```

### Add default route

```
# route add -inet6 -prefixlen 0 default 2001:beef::1
```
