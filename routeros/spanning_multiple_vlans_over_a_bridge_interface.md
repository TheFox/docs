# Spanning Multiple VLANs Over a Bridge Interface

This document describes how to span multiple VLANs over a [Bridge Interface](https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge) using RouterOS on a MikroTik router. 

## Introduction

There is difference between *having a VLAN endpoint per port* and *having multiple VLANs spanning over a [Bridge Interface](https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge)*.

[Bridge VLAN Filtering](https://wiki.mikrotik.com/wiki/Manual:Interface/Bridge#Bridge_VLAN_Filtering) describes how to setup a specific VLAN on a port.

This document describes how to span multiple VLANs over a Bridge. It should make clear that there is difference between one VLAN per port and spanning multiple VLANs over the whole bridge. The latter forwards all VLANs through the bridge, meaning that all ports receive all VLAN packets. It does not use a VLAN trunk.

## TODO
