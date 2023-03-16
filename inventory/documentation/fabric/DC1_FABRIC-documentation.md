# DC1_FABRIC

# Table of Contents
<!-- toc -->

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

<!-- toc -->
# Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision |
| --- | ---- | ---- | ------------- | -------- | -------------------------- |
| DC1_FABRIC | l3leaf | DC1_LEAF-1A | 172.16.47.31/24 | vEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1_LEAF-1B | 172.16.47.32/24 | vEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1_LEAF-2A | 172.16.47.33/24 | vEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1_LEAF-2B | 172.16.47.34/24 | vEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1_LEAF-3A | 172.16.47.35/24 | vEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1_LEAF-3B | 172.16.47.36/24 | vEOS | Provisioned |
| DC1_FABRIC | spine | DC1_SPINE-1 | 172.16.47.21/24 | vEOS | Provisioned |
| DC1_FABRIC | spine | DC1_SPINE-2 | 172.16.47.22/24 | vEOS | Provisioned |
| DC1_FABRIC | spine | DC1_SPINE-3 | 172.16.47.23/24 | vEOS | Provisioned |
| DC1_FABRIC | spine | DC1_SPINE-4 | 172.16.47.24/24 | vEOS | Provisioned |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

## Fabric Switches with inband Management IP
| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

# Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | DC1_LEAF-1A | Ethernet1 | spine | DC1_SPINE-1 | Ethernet1 |
| l3leaf | DC1_LEAF-1A | Ethernet2 | spine | DC1_SPINE-2 | Ethernet1 |
| l3leaf | DC1_LEAF-1A | Ethernet3 | spine | DC1_SPINE-3 | Ethernet1 |
| l3leaf | DC1_LEAF-1A | Ethernet4 | spine | DC1_SPINE-4 | Ethernet1 |
| l3leaf | DC1_LEAF-1A | Ethernet5 | mlag_peer | DC1_LEAF-1B | Ethernet5 |
| l3leaf | DC1_LEAF-1B | Ethernet1 | spine | DC1_SPINE-1 | Ethernet2 |
| l3leaf | DC1_LEAF-1B | Ethernet2 | spine | DC1_SPINE-2 | Ethernet2 |
| l3leaf | DC1_LEAF-1B | Ethernet3 | spine | DC1_SPINE-3 | Ethernet2 |
| l3leaf | DC1_LEAF-1B | Ethernet4 | spine | DC1_SPINE-4 | Ethernet2 |
| l3leaf | DC1_LEAF-2A | Ethernet1 | spine | DC1_SPINE-1 | Ethernet3 |
| l3leaf | DC1_LEAF-2A | Ethernet2 | spine | DC1_SPINE-2 | Ethernet3 |
| l3leaf | DC1_LEAF-2A | Ethernet3 | spine | DC1_SPINE-3 | Ethernet3 |
| l3leaf | DC1_LEAF-2A | Ethernet4 | spine | DC1_SPINE-4 | Ethernet3 |
| l3leaf | DC1_LEAF-2A | Ethernet5 | mlag_peer | DC1_LEAF-2B | Ethernet5 |
| l3leaf | DC1_LEAF-2B | Ethernet1 | spine | DC1_SPINE-1 | Ethernet4 |
| l3leaf | DC1_LEAF-2B | Ethernet2 | spine | DC1_SPINE-2 | Ethernet4 |
| l3leaf | DC1_LEAF-2B | Ethernet3 | spine | DC1_SPINE-3 | Ethernet4 |
| l3leaf | DC1_LEAF-2B | Ethernet4 | spine | DC1_SPINE-4 | Ethernet4 |
| l3leaf | DC1_LEAF-3A | Ethernet1 | spine | DC1_SPINE-1 | Ethernet5 |
| l3leaf | DC1_LEAF-3A | Ethernet2 | spine | DC1_SPINE-2 | Ethernet5 |
| l3leaf | DC1_LEAF-3A | Ethernet3 | spine | DC1_SPINE-3 | Ethernet5 |
| l3leaf | DC1_LEAF-3A | Ethernet4 | spine | DC1_SPINE-4 | Ethernet5 |
| l3leaf | DC1_LEAF-3A | Ethernet5 | mlag_peer | DC1_LEAF-3B | Ethernet5 |
| l3leaf | DC1_LEAF-3B | Ethernet1 | spine | DC1_SPINE-1 | Ethernet6 |
| l3leaf | DC1_LEAF-3B | Ethernet2 | spine | DC1_SPINE-2 | Ethernet6 |
| l3leaf | DC1_LEAF-3B | Ethernet3 | spine | DC1_SPINE-3 | Ethernet6 |
| l3leaf | DC1_LEAF-3B | Ethernet4 | spine | DC1_SPINE-4 | Ethernet6 |

# Fabric IP Allocation

## Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 172.31.255.0/24 | 256 | 48 | 18.75 % |

## Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| DC1_LEAF-1A | Ethernet1 | 172.31.255.1/31 | DC1_SPINE-1 | Ethernet1 | 172.31.255.0/31 |
| DC1_LEAF-1A | Ethernet2 | 172.31.255.3/31 | DC1_SPINE-2 | Ethernet1 | 172.31.255.2/31 |
| DC1_LEAF-1A | Ethernet3 | 172.31.255.5/31 | DC1_SPINE-3 | Ethernet1 | 172.31.255.4/31 |
| DC1_LEAF-1A | Ethernet4 | 172.31.255.7/31 | DC1_SPINE-4 | Ethernet1 | 172.31.255.6/31 |
| DC1_LEAF-1B | Ethernet1 | 172.31.255.9/31 | DC1_SPINE-1 | Ethernet2 | 172.31.255.8/31 |
| DC1_LEAF-1B | Ethernet2 | 172.31.255.11/31 | DC1_SPINE-2 | Ethernet2 | 172.31.255.10/31 |
| DC1_LEAF-1B | Ethernet3 | 172.31.255.13/31 | DC1_SPINE-3 | Ethernet2 | 172.31.255.12/31 |
| DC1_LEAF-1B | Ethernet4 | 172.31.255.15/31 | DC1_SPINE-4 | Ethernet2 | 172.31.255.14/31 |
| DC1_LEAF-2A | Ethernet1 | 172.31.255.17/31 | DC1_SPINE-1 | Ethernet3 | 172.31.255.16/31 |
| DC1_LEAF-2A | Ethernet2 | 172.31.255.19/31 | DC1_SPINE-2 | Ethernet3 | 172.31.255.18/31 |
| DC1_LEAF-2A | Ethernet3 | 172.31.255.21/31 | DC1_SPINE-3 | Ethernet3 | 172.31.255.20/31 |
| DC1_LEAF-2A | Ethernet4 | 172.31.255.23/31 | DC1_SPINE-4 | Ethernet3 | 172.31.255.22/31 |
| DC1_LEAF-2B | Ethernet1 | 172.31.255.25/31 | DC1_SPINE-1 | Ethernet4 | 172.31.255.24/31 |
| DC1_LEAF-2B | Ethernet2 | 172.31.255.27/31 | DC1_SPINE-2 | Ethernet4 | 172.31.255.26/31 |
| DC1_LEAF-2B | Ethernet3 | 172.31.255.29/31 | DC1_SPINE-3 | Ethernet4 | 172.31.255.28/31 |
| DC1_LEAF-2B | Ethernet4 | 172.31.255.31/31 | DC1_SPINE-4 | Ethernet4 | 172.31.255.30/31 |
| DC1_LEAF-3A | Ethernet1 | 172.31.255.33/31 | DC1_SPINE-1 | Ethernet5 | 172.31.255.32/31 |
| DC1_LEAF-3A | Ethernet2 | 172.31.255.35/31 | DC1_SPINE-2 | Ethernet5 | 172.31.255.34/31 |
| DC1_LEAF-3A | Ethernet3 | 172.31.255.37/31 | DC1_SPINE-3 | Ethernet5 | 172.31.255.36/31 |
| DC1_LEAF-3A | Ethernet4 | 172.31.255.39/31 | DC1_SPINE-4 | Ethernet5 | 172.31.255.38/31 |
| DC1_LEAF-3B | Ethernet1 | 172.31.255.41/31 | DC1_SPINE-1 | Ethernet6 | 172.31.255.40/31 |
| DC1_LEAF-3B | Ethernet2 | 172.31.255.43/31 | DC1_SPINE-2 | Ethernet6 | 172.31.255.42/31 |
| DC1_LEAF-3B | Ethernet3 | 172.31.255.45/31 | DC1_SPINE-3 | Ethernet6 | 172.31.255.44/31 |
| DC1_LEAF-3B | Ethernet4 | 172.31.255.47/31 | DC1_SPINE-4 | Ethernet6 | 172.31.255.46/31 |

## Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 192.168.255.0/24 | 256 | 10 | 3.91 % |

## Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| DC1_FABRIC | DC1_LEAF-1A | 192.168.255.3/32 |
| DC1_FABRIC | DC1_LEAF-1B | 192.168.255.4/32 |
| DC1_FABRIC | DC1_LEAF-2A | 192.168.255.5/32 |
| DC1_FABRIC | DC1_LEAF-2B | 192.168.255.6/32 |
| DC1_FABRIC | DC1_LEAF-3A | 192.168.255.7/32 |
| DC1_FABRIC | DC1_LEAF-3B | 192.168.255.8/32 |
| DC1_FABRIC | DC1_SPINE-1 | 192.168.255.1/32 |
| DC1_FABRIC | DC1_SPINE-2 | 192.168.255.2/32 |
| DC1_FABRIC | DC1_SPINE-3 | 192.168.255.3/32 |
| DC1_FABRIC | DC1_SPINE-4 | 192.168.255.4/32 |

## VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| --------------------- | ------------------- | ------------------ | ------------------ |
| 192.168.254.0/24 | 256 | 6 | 2.35 % |

## VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| DC1_FABRIC | DC1_LEAF-1A | 192.168.254.3/32 |
| DC1_FABRIC | DC1_LEAF-1B | 192.168.254.3/32 |
| DC1_FABRIC | DC1_LEAF-2A | 192.168.254.5/32 |
| DC1_FABRIC | DC1_LEAF-2B | 192.168.254.5/32 |
| DC1_FABRIC | DC1_LEAF-3A | 192.168.254.7/32 |
| DC1_FABRIC | DC1_LEAF-3B | 192.168.254.7/32 |
