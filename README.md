# Vagrant

![Vagrant](https://img.shields.io/badge/-Vagrant-1563FF?style=for-the-badge&logo=Vagrant&logoColor=white)

Contains Vagrantfiles and the related config files used to setup the machines 

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Prerequisites](#prerequisites)
- [Basics](#basics)
  - [Vagrant Boxes](#vagrant-boxes)
  - [Synced Folders](#synced-folders)
  - [Basic commands](#basic-commands)
- [Networking](#networking)
  - [Private Networking](#private-networking)
  - [Port Forwarding](#port-forwarding)
- [Provisioners](#provisioners)
  - [Shell Provisioner](#shell-provisioner)
  - [Ansible_Local Provisioner](#ansible_local-provisioner)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

---

### Prerequisites
- Start by downloading [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (This will be used as [our provider](https://developer.hashicorp.com/vagrant/docs/providers))
- After that Install [Vagrant software](https://developer.hashicorp.com/vagrant/downloads)

### Basics

#### [Vagrant Boxes](https://developer.hashicorp.com/vagrant/docs/boxes)
- The package format for Vagrant environments where we specify a box environment and OS in the **Vagrantfile**
- It's better to also specify the exact box version just to [avoid any breaking changes that might happen](https://github.com/theJaxon/Kontainer8/blob/main/Vagrantfile#L5) (Don't use latest)

```ruby
config.vm.box = "ubuntu/jammy64"
config.vm.box_version = "20220718.0.1"
```

#### [Synced Folders](https://developer.hashicorp.com/vagrant/docs/synced-folders)
- Enable Vagrant to sync a folder on the host machine to the guest machine, allowing you to continue working on your project's files on your host machine, but use the resources in the guest machine to compile or run your project.
- We stick to the default and use **`/vagrant`** as the directory that will be synced

```ruby
config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
```

#### Basic commands
```bash
# Bring up the machines specified in Vagrantfile
# Downloads Vagrant boxes if not found
# https://developer.hashicorp.com/vagrant/docs/cli/up
vagrant up

# Restart Vagrant machines
# The equivalent of running a halt followed by an up
# https://developer.hashicorp.com/vagrant/docs/cli/reload
vagrant reload

# Re-Provision the machines (re-exectues using whatever specified provisioner - ex: bash, ansible)
# Executed on a running environment
# https://developer.hashicorp.com/vagrant/docs/cli/provision
vagrant provision

# SSH Into the machine (If only one machine in use then no need for name)
# https://developer.hashicorp.com/vagrant/docs/cli/ssh
vagrant ssh 

# If more than one machine exists then specify the name
vagrant ssh <name>

# Take a snapshot from the machine to be restored at any point in the future
# https://developer.hashicorp.com/vagrant/docs/cli/snapshot
vagrant snapshot save <name>

# Restore from the snapshot
vagrant snapshot restore <name>

# Shut down the VM
# https://developer.hashicorp.com/vagrant/docs/cli/halt 
vagrant halt

# Destroy the environment
# After running this command, your computer should be left at a clean state, as if you never created the guest machine in the first place.
# https://developer.hashicorp.com/vagrant/docs/cli/destroy
vagrant destroy -f
```

---

### Networking

#### [Private Networking](https://developer.hashicorp.com/vagrant/docs/networking/private_network)
- Private networks allows guest machine access with an address that's not publicly accessible (the address is within [private address space](https://en.wikipedia.org/wiki/Private_network#Private_IPv4_address_spaces))
- Vagrant Cloud is what you can consider the equivalent of Dockerhub, just a place to [fetch the needed Vagrant Boxes from](https://app.vagrantup.com/boxes/search)
- Some [quality Vagrant boxes](https://app.vagrantup.com/bento) are being maintained by the [Bento Project](https://github.com/chef/bento)

```ruby
config.vm.network "private_network", ip: "192.168.50.210"
```

#### [Port Forwarding](https://developer.hashicorp.com/vagrant/docs/networking/forwarded_ports)
- [Allows accessing specific port on the vagrant machine by mapping it to another port on the host OS](https://github.com/theJaxon/Vagrant/blob/main/consul-vault/Vagrantfile#L16)
- Example - a web server listening on port 80 can have forwarded port mapping to port 8080

```ruby
# Nginx let's say
config.vm.network "forwarded_port", guest: 80, host: 8080
```

---

### [Provisioners](https://developer.hashicorp.com/vagrant/docs/provisioning)
- Allows automatic software installation and configuration

#### [Shell Provisioner](https://developer.hashicorp.com/vagrant/docs/provisioning/shell)
- Allows executing a script on the vagrant machine
- Can be [`inline` script](https://github.com/theJaxon/RHCE_ENV/blob/master/Vagrantfile#L7) where it's declared inside the **Vagrantfile**
- Supports [`path` where you point to shell script location](https://github.com/theJaxon/RHCSA_ENV/blob/master/Vagrantfile#L20) and it gets executed

#### [Ansible_Local Provisioner](https://developer.hashicorp.com/vagrant/docs/provisioning/ansible_local)
- Doesn't require any additional software on host OS
- Ansible gets installed automatically on the guest machine
- Allows [ansible playbooks execution](https://github.com/theJaxon/Kontainer8/blob/main/Vagrantfile#L30) on the vagrant machine
