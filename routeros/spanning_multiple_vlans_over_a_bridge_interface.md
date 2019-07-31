# Spanning Multiple VLANs Over a Bridge Interface

This document describes how to span multiple VLANs over a [Bridge Interface](https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge) using RouterOS on a MikroTik router. 

## Introduction

There is a difference between *having a VLAN endpoint per port* and *having multiple VLANs spanning over a [Bridge Interface](https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge)*.

[Bridge VLAN Filtering](https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge#Bridge_VLAN_Filtering) describes how to setup a specific VLAN on a port. It matters on which ports the cables are connected since the ports untag the VLAN packets.

This document describes how to span multiple VLANs over a Bridge. It should make clear that there is difference between one VLAN per port and spanning multiple VLANs over the whole Bridge. The latter forwards all VLANs through the Bridge, meaning that all VLAN packets can go through all ports. The ports share the same VLANs, in- and outgoing, because the port itself and the Bridge do not untag any VLAN packets. The VLAN packets will be untagged by VLAN interfaces, as you will see later.

## Requirements

What do we want for our setup?

- A Router, named *r1*.
- Two Switches, named *sw1* and *sw2*.
- An Internet gateway.
- Three VLANs: one Desktop VLAN for desktop devices using VLAN ID 10. One VLAN for servers using VLAN ID 11. Another for guests using VLAN ID 12.
- The router r1 is the default gateway for all devices in all VLANs.
- Firewall rules. We do not want guests to connect to the Desktop VLAN nor the Server VLAN. Guests are allowed to connect only to the Internet.

The Internet gateway is connected to the Ethernet port 1 (*eth1*) on the r1 router. Switches sw1 and sw2 are connected to Ethernet port 2 (*eth2*) and 3 (*eth3*). Both using a VLAN trunk for all VLANs. We assume that the router r1 will have 192.168.10.1 in the Desktop VLAN and 192.168.11.1 in the Server VLAN and 192.168.12.1 in the Guest VLAN. Devices in the Desktop VLAN will use 192.168.10.1 as default gateway, devices in the Server VLAN will use 192.168.11.1 as default gateway and devices in the Guest VLAN will use 192.168.12.1 as default gateway. All owned by the same device, r1.

## Bridge Setup

First add a new Bridge.

```
/interface bridge add name=bridge1
```

Assign Port 2 and 3 to the bridge. Not the Internet gateway which is on *eth1*.

```
/interface bridge port
add bridge=bridge1 interface=eth2
add bridge=bridge1 interface=eth3
```

**Note:** Since this document focus on VLANs I'll not cover NATing to the Internet. I assume this is already working, or not. It would be the same setup as if you would not use VLANs at all. So it does not matter for this example.

## VLAN Setup

Now we need to add the VLAN interfaces.

```
/interface vlan
add interface=bridge1 vlan-id=10 name=vlan_desktop
add interface=bridge1 vlan-id=11 name=vlan_server
add interface=bridge1 vlan-id=12 name=vlan_guest
```

## Addresses Setup

We also want our router to be the default gateway for each VLAN.

```
/ip address
add address=192.168.10.1/24 network=192.168.10.0 interface=vlan_desktop
add address=192.168.11.1/24 network=192.168.11.0 interface=vlan_server
add address=192.168.12.1/24 network=192.168.12.0 interface=vlan_guest
```

Now we come to the interesting part of the setup, the Firwall rules.

## Firewall Setup

We want devices in the Desktop VLAN to be able to access the Router, but not the devices from the other VLANs. Guests should only be able to connect to the Internet.

**Note:** I will not list the default rules your firewall should have. For example the good old *Accept established,related,untracked* or *Drop invalid*, or any other allowed service running on the router.

Allow ping: this rules make sure that only the devices from each VLAN are able to ping (ICMP) the corresponding router IP. Those are optional and nice to have. You can skip those rules if you want.

```
/ip firewall filter
add action=accept chain=input protocol=icmp src-address=192.168.10.0/24 dst-address=192.168.10.1 in-interface=vlan_desktop comment="Allow ICMP from Desktop VLAN"
add action=accept chain=input protocol=icmp src-address=192.168.11.0/24 dst-address=192.168.11.1 in-interface=vlan_server comment="Allow ICMP from Server VLAN"
add action=accept chain=input protocol=icmp src-address=192.168.12.0/24 dst-address=192.168.12.1 in-interface=vlan_guest comment="Allow ICMP from Guest VLAN"
```

Allow all Desktop devices to connect to the router. Those rules are necessary not to loose the access to the router itself.

```
/ip firewall filter
add action=accept chain=input dst-port=22 protocol=tcp src-address=192.168.10.0/24 dst-address=192.168.10.1 in-interface=vlan_desktop comment="Allow SSH from Desktop VLAN"
add action=accept chain=input dst-port=80 protocol=tcp src-address=192.168.10.0/24 dst-address=192.168.10.1 in-interface=vlan_desktop comment="Allow HTTP from Desktop VLAN"
```

The last rule for the input chain should **drop everything** we didn't explicitly allow.

**Note:** Make sure you put all other rules above the following one. All services which the router should provide must be explicitly allowed and above the *Drop Everything Else* rule. Since RouterOS comes with a default policy *allow* we have to add this rule manually. If you do not add this rule you maybe allow the router accessed from the Internet.

```
/ip firewall filter add action=drop chain=input comment="End Of Input (Drop Everything Else)"
```

Now the forward rules.

Allow devices in the Desktop VLAN to access the Server VLAN and the Internet.

```
/ip firewall filter
add action=accept chain=forward in-interface=vlan_desktop out-interface=eth1 src-address=192.168.10.0/24 comment="Allow all from Desktop VLAN to Internet"
add action=accept chain=forward in-interface=vlan_desktop out-interface=vlan_server src-address=192.168.10.0/24 dst-address=192.168.11.0/24 comment="Allow all from Desktop VLAN to Server VLAN"
```

Allow Guests to access the Internet and only the Internet.

```
/ip firewall filter add action=accept chain=forward in-interface=vlan_guest out-interface=eth1 src-address=192.168.12.0/24 comment="Allow all from Guest VLAN to Internet"
```

Again, drop everything. This time in the **forward chain**.

**Note:** If you would not add the following rule you would have to manually drop everything which comes from the Guest VLAN. The other rules are useless without a bottom rule dropping everything.

```
/ip firewall filter add action=drop chain=forward comment="End Of Forward (Drop Everything Else)"
```

## Conclusion

In this setup the packets are flowing through the Bridge without resistance. Those packets who wants to switch VLAN can be blocked by the firewall. In this way the VLANs can be isolated from each other. The packets will be untagged at the vlan_* interfaces, routed, and forwarded on the same or on a different VLAN interface.
