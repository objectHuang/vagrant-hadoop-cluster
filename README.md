# Vagrant Hadoop Cluster

This is a little personal project that attempts to create a working virtual Hadoop cluster with Hadoop 3.3.6 + Hive 3.1.3 + Spark 3.4.2, using Vagrant. 

---
## Requirements

- VirtualBox 6.0/7.0
- Vagrant >3.0
- Minimum of 32GB RAM (as-is, the full cluster allocates 20GB of RAM in total - 8GB for the namenode, 4GB for each datanode), you may adjust the RAM for each node, so it can run on a 16GB machine.

---
## Basic management

To provision the cluster:

> vagrant up

as long as you run the vagrant up (not just first time) vagrant will help us to start all the services:

Hadoop Cluster (NameNode, DataNode, Yarn etc)
Hive (MetaData Service and HiveServer 2)
Spark Cluster (Master and workers)
Zeppelin


The first time this command is executed, it's going to take awhile, because vagrant will provision the machines. The second time it won't take so long. Also, to "vagrant up" a single node:

> vagrant up < host name >

To ssh into any of the machines:

> vagrant ssh < host name >

ssh is installed and configured within each machine so once inside a machine, you can ssh into any other machine with the host name or ip address:

> **namenode$** ssh < host name >\
> **namenode$** ssh < host ip address >

To halt the nodes (and save changes):

> vagrant halt

Again, you can halt a single node:

> vagrant halt < host name >

To completely wipe the nodes and state:

> vagrant destroy -f

To wipe a single node:

> vagrant destroy < host name >

To check the statuses of the vagrant environment:

> vagrant global-status



Verify if daemons are working correctly with the jps command in each node. The processes that should be running are listed in the [**Initial cluster setup**](#initial-cluster-setup).

Additionally, verify if all datanodes are listed in Hadoop's WebUI: [**192.168.2.10:9870**](192.168.2.10:9870)

---
## Initial cluster setup

The initial cluster is configured with four nodes:
1. **namenode** (8GB RAM): this node is more powerful than the others and is configured to run the following processes: 
   - *Namenode* 
   - *SecondaryNamenode* 
   - *ResourceManager* 
2. **datanode1** (4GB RAM): this node runs the following processes:
   - *NodeManager*
   - *Datanode*
3. **datanode2** (4GB RAM): this node runs the following processes:
   - *NodeManager*
   - *Datanode*
4. **datanode3** (4GB RAM): this node runs the following processes:
   - *NodeManager*
   - *Datanode*

Scaling horizontally by adding datanodes is a matter of editing the following files:
 - [Vagrantfile](./Vagrantfile)
 - [ssh-setup.sh](./scripts/ssh-setup.sh)
 - [workers](./configs/hadoop/workers) (Hadoop)
 - [workers](./configs/spark/workers) (Spark)

Scaling vertically by adding resources to each node is a matter of editing the following files:
 - [Vagrantfile](./Vagrantfile)

To access different service WebUI:

Hadoop/Yarn applications:

http://192.168.2.10:8088/cluster

Hadoop NameNode WebUI:

http://192.168.2.10:9870/dfshealth.html#tab-overview

Hive Server:

http://192.168.2.10:10002

Spark:

http://192.168.2.10:8080

Zeppelin:

http://192.168.2.10:9194