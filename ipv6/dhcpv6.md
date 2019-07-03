
# [INCOMPLETE] IPv6 DHCP

On macOS switch to root:

```bash
sudo -i
```

Print plist file to get DUID:
```bash
cat /var/db/dhcpclient/DUID_IA.plist
```

Extract the Base64 DUID from the XML:

```
AAEAASH6XYZ4e4q7hEk=
```

Then use a Base64 decoder like [CyberChef](https://gchq.github.io/CyberChef/) to first decode base64 and print it as Hex. "From Base64" and "To Hex". No Delimiter.

Use this hex to create a new Binding on RouterOS. The DUID now must have a "0x" prefix. Otherwise you will get an `failure: Invalid DUID!` error.

```
/ipv6 dhcp-server binding add disabled=no duid="0x0001000121fa5d86787b8abb8449" server=dhcp10_default iaid=0 address=2001:460:2f2c:ccc::52
```
