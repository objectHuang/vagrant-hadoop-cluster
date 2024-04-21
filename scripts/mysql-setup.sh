#!/bin/bash

#!/bin/bash

echo "############## Setting-up MySQL#############################"

mysql -V &> /dev/null || {
sudo apt-get -qq install -y mysql-server

sudo mysql -e "create user 'hiveuser'@'%' identified by 'hive'"
sudo mysql -e "GRANT ALL ON *.* TO 'hiveuser'@'%'"
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart
}