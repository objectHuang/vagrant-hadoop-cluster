#!/bin/bash 

#####################################################
# SSH
#####################################################

echo "Setup SSH"

# Check for private key for vm-vm comm
[ -f /vagrant/id_rsa ] || {
  ssh-keygen -t rsa -f /vagrant/id_rsa -q -N ''
}

# Deploy key
[ -f /home/vagrant/.ssh/id_rsa ] || {
    cp /vagrant/id_rsa* /home/vagrant/.ssh/
    chmod 0600 /home/vagrant/.ssh/id_rsa
}

# Allow ssh passwordless
grep 'vagrant@' ~/.ssh/authorized_keys &>/dev/null || {
  cat /vagrant/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 0600 ~/.ssh/authorized_keys
}

# Exclude node* from host checking
cat > ~/.ssh/config <<EOF
Host datanode1
   IdentityFile "~/.ssh/id_rsa"
   StrictHostKeyChecking no
Host datanode2
   IdentityFile "~/.ssh/id_rsa"
   StrictHostKeyChecking no
Host datanode3
   IdentityFile "~/.ssh/id_rsa"
   StrictHostKeyChecking no
Host namenode
   IdentityFile "~/.ssh/id_rsa"
   StrictHostKeyChecking no
EOF

# Populate /etc/hosts
sudo chmod 777 /etc/hosts
grep "192.168.2.11" /etc/hosts &> /dev/null || sudo echo "192.168.2.11 datanode1" >> /etc/hosts
grep "192.168.2.12" /etc/hosts &> /dev/null || sudo echo "192.168.2.12 datanode2" >> /etc/hosts
grep "192.168.2.13" /etc/hosts &> /dev/null || sudo echo "192.168.2.13 datanode3" >> /etc/hosts
grep "192.168.2.14" /etc/hosts &> /dev/null || sudo echo "192.168.2.14 datanode4" >> /etc/hosts
grep "192.168.2.15" /etc/hosts &> /dev/null || sudo echo "192.168.2.15 datanode5" >> /etc/hosts
grep "192.168.2.16" /etc/hosts &> /dev/null || sudo echo "192.168.2.16 datanode6" >> /etc/hosts
grep "192.168.2.17" /etc/hosts &> /dev/null || sudo echo "192.168.2.17 datanode7" >> /etc/hosts
grep "192.168.2.18" /etc/hosts &> /dev/null || sudo echo "192.168.2.18 datanode8" >> /etc/hosts

grep "192.168.2.10" /etc/hosts &> /dev/null || sudo echo "192.168.2.10 namenode" >> /etc/hosts

# Avoid host resolution confusions
grep -v "^127.0." /etc/hosts > hosts.tmp
sudo mv hosts.tmp /etc/hosts

echo "Setup SSH Completed"