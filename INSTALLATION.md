# Installation Process


## 1. Installation

To use this example, it is higly recommended to work in a Python virtual-environment:

```shell
# Configure Python virtual environment
$ virtualenv -p $(which python2.7) .venv
$ source .venv/bin/activate

# Install Python requirements
$ pip install -r requirements.txt
```

You also have to install `arista.cvp` collection to be able to connect to CloudVision

```shell
$ ansible-galaxy collection install arista-cvp-1.0.1.tar.gz -p collections
```

## 2. Configure DHCP server on CloudVision

In this scenario, we use CloudVision (CV) as ZTP server to provision devices and register them onto CV.

Once you get mac-address of your switches, edit file `/etc/dhcp/dhcpd.conf` in CloudVision. In this scenario, CV use following address to connect to devices: `10.255.0.1`

```shell
$ vi /etc/dhcp/dhcpd.conf

subnet 10.255.0.0 netmask 255.255.255.0 {
    range 10.255.0.200 10.255.0.250;
    option routers 10.255.0.1;
    option domain-name-servers 10.83.28.52, 10.83.29.222;
    option bootfile-name "http://10.255.0.1/ztp/bootstrap";
}

#############################################################
host DC1-SPINE1 {
    option host-name "DC1-SPINE1";
    hardware ethernet 0c:1d:c0:1d:62:01;
    fixed-address 10.255.0.11;
    option bootfile-name "http://10.255.0.1/ztp/bootstrap";
}

host DC1-SPINE2 {
    option host-name "DC1-SPINE2";
    hardware ethernet 0c:1d:c0:1d:62:02;
    fixed-address 10.255.0.12;
    option bootfile-name "http://10.255.0.1/ztp/bootstrap";
}

host DC1-LEAF1A {
    option host-name "DC1-LEAF1A";
    hardware ethernet 0c:1d:c0:1d:62:11;
    fixed-address 10.255.0.13;
    option bootfile-name "http://10.255.0.1/ztp/bootstrap";
}

host DC1-LEAF1B {
    option host-name "DC1-LEAF1B";
    hardware ethernet 0c:1d:c0:1d:62:12;
    fixed-address 10.255.0.14;
    option bootfile-name "http://10.255.0.1/ztp/bootstrap";
}

host DC1-LEAF2A {
    option host-name "DC1-LEAF2A";
    hardware ethernet 0c:1d:c0:1d:62:21;
    fixed-address 10.255.0.15;
    option bootfile-name "http://10.255.0.1/ztp/bootstrap";
}

host DC1-LEAF2B {
    option host-name "DC1-LEAF2B";
    hardware ethernet 0c:1d:c0:1d:62:22;
    fixed-address 10.255.0.16;
    option bootfile-name "http://10.255.0.1/ztp/bootstrap";
}

```

> Be sure to update ethernet address to match MAC addresses configured on your switches.

Then, restart your DHCP server:

```shell
$ service dhcpd restart
```

From here, you can start your devices and let CVP register them into `undefined` container.


## Edit `DC1_FABRIC.yml` to configure devices information:__

- Add / Remove devices in the list.
- Management IP of every device.

In this example, we only use `spine` and `l3leafs` devices. Below is an example for `l3leafs`:

```yaml
  node_groups:
    DC1_LEAF1:
      bgp_as: 65101
      nodes:
        DC1-LEAF1A:
          id: 1
          mgmt_ip: 10.255.0.13/24
          spine_interfaces: [ Ethernet1, Ethernet1 ]
        DC1-LEAF1B:
          id: 2
          mgmt_ip: 10.255.0.14/24
          spine_interfaces: [ Ethernet2, Ethernet2 ]
```

## 4. Edit Inventory

In the inventory, update CloudVision information to target your own setup:

```yaml
# inventory.yml
all:
  children:
    CVP:
      hosts:
        cvp:
          ansible_httpapi_host: 10.83.28.164
          ansible_host: 10.83.28.164
          ansible_user: ansible
          ansible_password: ansible
          ansible_httpapi_port: 443
          # Configuration to get Virtual Env information
          ansible_python_interpreter: $(which python)
```