
#!/bin/bash


echo "Setup Zeppelin"

# Make tar folder if it doesn't exist
mkdir -p ../../vagrant/tar/

# If Hive tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^zeppelin &> /dev/null || 
wget https://dlcdn.apache.org/zeppelin/zeppelin-0.10.1/zeppelin-0.10.1-bin-all.tgz -P ../../vagrant/tar/


ls /usr/local/zeppelin &> /dev/null || {
sudo tar -xvf ../../vagrant/tar/zeppelin-0.10.1-bin-all.tgz -C /usr/local/
sudo mv -T /usr/local/zeppelin-0.10.1-bin-all /usr/local/zeppelin
}



grep ZEPPELIN .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# Zeppelin Variables START
export ZEPPELIN_HOME=/usr/local/zeppelin
# Zeppelin Variables END
EOF

export ZEPPELIN_HOME=/usr/local/zeppelin

sudo cp ../../vagrant/configs/zeppelin/* $ZEPPELIN_HOME/conf

sudo chmod 777 /usr/local/zeppelin/
sudo chown vagrant:vagrant /usr/local/zeppelin/
sudo chown vagrant:vagrant /usr/local/zeppelin/*
sudo chown vagrant:vagrant /usr/local/zeppelin/notebook
sudo chown vagrant:vagrant /usr/local/zeppelin/notebook/*
sudo chown vagrant:vagrant /usr/local/zeppelin/conf/
sudo chown vagrant:vagrant /usr/local/zeppelin/conf/*


echo "Setup Zeppelin Completed"