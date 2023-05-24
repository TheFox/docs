# macOS IPv6 Commands

- In this examples I assume your IPv6 address of `en0` interface is `2001:db8::2` and the default gateway is your router `2001:db8::1`. I use `2001:db8::3` as an example for an other device in the same network.
- Tested under macOS 10.13.6 **High Sierra**.
- Tested under macOS 10.14.5 **Mojave**.

### Manual Page

```
man route
```

### Flush

```
sudo route flush -inet6
```

### Add default route

```
sudo route add -inet6 -prefixlen 0 default 2001:db8::1
```

### Change default gateway

```
sudo route change -inet6 default -interface 2001:db8::1
```

### Remove default route

```
sudo route delete -inet6 ::/0
```

### Remove default utun0 route

```
sudo route delete -ifscope utun0 -inet6 ::/0
```

### Remove host route

```
sudo route delete -ifscope en0 -inet6 -host 2001:db8::3
```

### Disable IPv6

```
networksetup -listallnetworkservices
networksetup -setv6off LAN
networksetup -setv6off WLAN
```

## References

- [Linux IPv6 HOWTO](https://mirrors.deepspace6.net/Linux+IPv6-HOWTO/x1144.html)
- [simple ipv6 on a home network cheatsheet](https://grox.net/sysadm/net/ipv6_local_net.howto)
- [how to config default ipv6 route using route command](https://stackoverflow.com/questions/47234790/how-to-config-default-ipv6-route-using-route-command)
- [How to change the default gateway of a Mac OSX machine](https://apple.stackexchange.com/questions/33097/how-to-change-the-default-gateway-of-a-mac-osx-machine)
