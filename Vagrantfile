# -*- mode: ruby -*-
# vi: set ft=ruby :

#####################################################
# Cluster
#####################################################

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box    
    # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
  end

  #config.landrush.enabled = true

  config.vm.base_mac = nil
  config.vm.provision "shell", privileged: false, path: "scripts/ssh-setup.sh"
  config.vm.provision "shell", privileged: false, path: "scripts/utils-setup.sh"
  config.vm.provision "shell", privileged: false, path: "scripts/hadoop-setup.sh"
  config.vm.provision "shell", privileged: false, path: "scripts/tez-setup.sh"
  config.vm.provision "shell", privileged: false, path: "scripts/spark-setup.sh"
  config.vm.provider :virtualbox do |v, override|
    override.vm.box_url = "https://app.vagrantup.com/ubuntu/boxes/focal64/versions/20220207.0.0/providers/virtualbox.box"
    v.customize ["modifyvm", :id, "--memory", "4096"]    
    v.cpus = 2
  end

  config.vm.define :datanode1 do |datanode1_config|
    datanode1_config.vm.network :private_network, ip: "192.168.2.11"
    #datanode1_config.vm.network :public_network
    datanode1_config.vm.hostname = "datanode1"
  end

  config.vm.define :datanode2 do |datanode2_config|
    datanode2_config.vm.network :private_network, ip: "192.168.2.12"
    #datanode2_config.vm.network :public_network
    datanode2_config.vm.hostname = "datanode2"
  end

  config.vm.define :datanode3 do |datanode3_config|
    datanode3_config.vm.network :private_network, ip: "192.168.2.13"
    #datanode3_config.vm.network :public_network
    datanode3_config.vm.hostname = "datanode3"
  end

  config.vm.define :datanode4 do |datanode4_config|
    datanode4_config.vm.network :private_network, ip: "192.168.2.14"
    #datanode3_config.vm.network :public_network
    datanode4_config.vm.hostname = "datanode4"
  end

  config.vm.define :datanode5 do |datanode5_config|
    datanode5_config.vm.network :private_network, ip: "192.168.2.15"
    #datanode3_config.vm.network :public_network
    datanode5_config.vm.hostname = "datanode5"
  end

  config.vm.define :datanode6 do |datanode6_config|
    datanode6_config.vm.network :private_network, ip: "192.168.2.16"
    #datanode3_config.vm.network :public_network
    datanode6_config.vm.hostname = "datanode6"
  end

  config.vm.define :datanode7 do |datanode7_config|
    datanode7_config.vm.network :private_network, ip: "192.168.2.17"
    #datanode3_config.vm.network :public_network
    datanode7_config.vm.hostname = "datanode7"
  end

  config.vm.define :datanode8 do |datanode8_config|
    datanode8_config.vm.network :private_network, ip: "192.168.2.18"
    #datanode3_config.vm.network :public_network
    datanode8_config.vm.hostname = "datanode8"
  end

  config.vm.define :namenode do |namenode_config|
    namenode_config.vm.network :private_network, ip: "192.168.2.10"
    #namenode_config.vm.network :public_network
    namenode_config.vm.hostname = "namenode"
    namenode_config.vm.provider :virtualbox do |namenode_config_v, override|
      namenode_config_v.customize ["modifyvm", :id, "--memory", "8192"]
      namenode_config_v.cpus = 2
    end
    namenode_config.vm.provision "shell", privileged: false, path: "scripts/mysql-setup.sh"    
    namenode_config.vm.provision "shell", privileged: false, path: "scripts/hive-setup.sh"    
    namenode_config.vm.provision "shell", privileged: false, path: "scripts/spark-setup-namenode.sh"    
    namenode_config.vm.provision "shell", privileged: false, path: "scripts/tez-setup-namenode.sh"
    namenode_config.vm.provision "shell", privileged: false, path: "scripts/zeppelin-setup.sh"
    namenode_config.vm.provision "shell", privileged: false, path: "scripts/livy-setup.sh"

    namenode_config.vm.provision "shell", privileged: false, path: "scripts/start-all-services.sh",run: "always"
  end

end
