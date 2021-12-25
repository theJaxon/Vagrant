# Consul-Vault 

![Consul](https://img.shields.io/badge/-consul-F24C53?style=for-the-badge&logo=consul&logoColor=white)
![Vault](https://img.shields.io/badge/-vault-000000?style=for-the-badge&logo=vault&logoColor=white)
![Vagrant](https://img.shields.io/badge/-Vagrant-1563FF?style=for-the-badge&logo=Vagrant&logoColor=white)
![Ansible](https://img.shields.io/badge/-ansible-C9284D?style=for-the-badge&logo=ansible&logoColor=white)

Running Vault in High Availability mode using Consul as a default Storage Backend, Vagrant Machines as Nodes and Ansible for the Deployment

- Based on the tutorial [Vault High Availability with Consul](https://learn.hashicorp.com/tutorials/vault/ha-with-consul)
- A Consul cluster that's Highly available consists of no less than 3 Nodes (So that it can tolerate the failing of a single node)
- For production use cases the Consul cluster should ideally consist of no less than 5 Nodes 
- Vault is installed on 2 Nodes running Consul agent in Client mode

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Consul-Vault](#consul-vault)
    - [How to use the project](#how-to-use-the-project)
    - [Vagrant Machines Details](#vagrant-machines-details)
    - [Forwarded Ports](#forwarded-ports)
    - [What could be enhanced](#what-could-be-enhanced)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

---

### How to use the project 
```bash
# Clone the repo 
git clone https://github.com/theJaxon/Vagrant.git

# change directory to where Vagrantfile for this project exists 
cd Vagrant/consul-vault

# Wait for the nodes to be ready
vagrant up

# Access any node via SSH 
vagrant ssh <Machine>

# Show list of running consul agents 
consul members 
```

```bash
# If everything worked as expected the output of consul members command should be 

Node            Address           Status  Type    Build   Protocol  DC          Partition  Segment
consul-server1  10.1.42.101:8301  alive   server  1.11.1  2         vagrant-dc  default    <all>
consul-server2  10.1.42.102:8301  alive   server  1.11.1  2         vagrant-dc  default    <all>
consul-server3  10.1.42.103:8301  alive   server  1.11.1  2         vagrant-dc  default    <all>
vault-server1   10.1.42.201:8301  alive   client  1.11.1  2         vagrant-dc  default    <default>
vault-server2   10.1.42.202:8301  alive   client  1.11.1  2         vagrant-dc  default    <default>
```

---

### Vagrant Machines Details 

|     Machine    |      IP     | Port | Consul Agent Mode |
|:--------------:|:-----------:|:----:|:-----------------:|
| consul-server1 | 10.1.42.101 | 8501 |       Server      |
| consul-server2 | 10.1.42.102 | 8502 |       Server      |
| consul-server3 | 10.1.42.103 | 8503 |       Server      |
|  vault-server1 | 10.1.42.201 | 8201 |       Client      |
|  vault-server2 | 10.1.42.202 | 8202 |       Client      |


![Consul-Cluster](https://github.com/theJaxon/Vagrant/blob/main/consul-vault/Diagram/consul-cluster.png)

---

### Forwarded Ports
- The list of ports listed in the table above server the purpose of allowing UI Access for Consul agents in Server mode and for Vault UI
- Port `8500` from Consul Servers and `8200` from Vault Servers were forwarded 
- To access the UI any of the following approaches should work

|       UI       |   Via Forwarded Port  |      Via Machine IP     |
|:--------------:|:---------------------:|:-----------------------:|
| consul-server1 | http://localhost:8501 | http://10.1.42.101:8500 |
| consul-server2 | http://localhost:8502 | http://10.1.42.102:8500 |
| consul-server3 | http://localhost:8503 | http://10.1.42.103:8500 |
|  vault-server1 | http://localhost:8201 | http://10.1.42.201:8200 |
|  vault-server2 | http://localhost:8202 | http://10.1.42.202:8200 |

---

### What could be enhanced 
- In order for this setup to be truly dynamic the [retry_join line](https://github.com/theJaxon/Vagrant/blob/main/consul-vault/consul/templates/consul.hcl.j2#L11) should be changed to allow fetching the IPs of hosts in consul group (Which i still wasn't able to do)