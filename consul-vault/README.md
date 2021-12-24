# Consul-Vault 
Running Vault in High Availability mode using Consul as a default Storage Backend

- Based on the tutorial [Vault High Availability with Consul](https://learn.hashicorp.com/tutorials/vault/ha-with-consul)
- A Consul cluster that's Highly available consists of no less than 3 Nodes (So that it can tolerate the failing of a single node)
- For production use cases the Consul cluster should ideally consist of no less than 5 Nodes 
- Vault is installed on 2 Nodes running Consul agent in Client mode

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

### What could be enhanced 
- In order for this setup to be truly dynamic the [retry_join line](https://github.com/theJaxon/Vagrant/blob/main/consul-vault/consul/templates/consul.hcl.j2#L11) should be changed to allow fetching the IPs of hosts in consul group (Which i still wasn't able to do)