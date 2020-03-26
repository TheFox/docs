# Firefox Config

```
about:config
```

## HTTPS-only

```
dom.sequrity.https_only_mode = true
```

## Disable DNS-over-HTTPS

- [Info](https://support.mozilla.org/en-US/kb/firefox-dns-over-https)

```
network.trr.mode = 5
```

## Disable WebRTC

- [Info](https://superuser.com/questions/1174019/how-can-i-reliably-prevent-my-local-ip-address-leaking-in-the-web-browsers)

```
media.peerconnection.enabled = false
```
