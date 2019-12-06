# Arista Validated Design with CloudVision deployment

## About

This example implement a basic __EVPN/VXLAN Fabric__ based on __[Arista Validated Design roles](https://github.com/aristanetworks/ansible-avd)__ with one layer of 2 spines and one layer of leafs (4 devices) using MLAG. Configuration deployment is not managed by eos EAPI, but through Arista CloudVision based on __[arista.cvp collection](https://github.com/aristanetworks/ansible-cvp/)__

It helps to demonstrate how to bring up an Arista EVPN/VXLAN Fabric from the first boot.

![Lab Topology](data/lab-topology.png)

> Lab is based on GNS3 topology and a CloudVision server running on a VMware instance.

## Getting Started

```shell
# Clone repository
# For git > 2.12
$ git clone --recurse-submodules https://github.com/titom73/ansible-avd-cloudvision-demo.git
# For git <2.13 >2.9
$ git clone --recursive https://github.com/titom73/ansible-avd-cloudvision-demo.git

# Move to folder
$ cd ansible-avd-cloudvision-demo

# Install python requirements
$ pip install -r requirements.txt

# Edit ZTP file
# Powerup your devices

# Run Ansible playbook 
$ ansible-playbook dc1-fabric-deploy-cvp.yml
```

> Getting started does not include management IP configuration. For complete installation, please refer to [installation guide](INSTALLATION.md) to configure correct environment.

## Ressources

- Ansible [Arista Validated Design](https://github.com/aristanetworks/ansible-avd) repository.
- [Ansible CloudVision Collection](https://github.com/aristanetworks/ansible-cvp) repository.
- [How to install](INSTALL.md) demo environment.
- [Detailled demo script](DEMO.md).

## License

Project is published under [3-Clause BSD License](LICENSE).
