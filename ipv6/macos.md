# macOS IPv6 Commands

- Commands with a `$` at the beginning can be run as normal user.
- Commands with a `#` at the beginning must be run as root user.
- In this examples I assume your IPv6 address of `en0` interface is `2001:db8::2` and the default gateway is `2001:db8::1`.
- Tested under macOS 10.13.6 High Sierra.
- Tested under macOS 10.14.5 Mojave.

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
# route add -inet6 -prefixlen 0 default 2001:db8::1
```

### Change default gateway

```
route change -inet6 default -interface 2001:db8::1
```

### Remove default route

```
route delete -inet6 ::/0
```

### Remove default utun0 route

```
# route delete -ifscope utun0 -inet6 ::/0
```

## References

- [Linux IPv6 HOWTO](https://mirrors.deepspace6.net/Linux+IPv6-HOWTO/x1144.html)
- [simple ipv6 on a home network cheatsheet](https://grox.net/sysadm/net/ipv6_local_net.howto)
- [how to config default ipv6 route using route command](https://stackoverflow.com/questions/47234790/how-to-config-default-ipv6-route-using-route-command)
- [How to change the default gateway of a Mac OSX machine](https://apple.stackexchange.com/questions/33097/how-to-change-the-default-gateway-of-a-mac-osx-machine)
