#!/bin/bash 

echo "Setup Java/Scala/Python"

######################################
# INSTALL JDK
######################################

# If jdk is not installed, install OpenJDK 8
java -version &> /dev/null || {
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk
sudo apt-get install net-tools
}

# Set environmental variables
grep JAVA .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# JAVA Variables START
export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
# JAVA Variables END
EOF

######################################
# INSTALL Scala and sbt
######################################

# Make tar folder if it doesn't exist
mkdir -p ../../vagrant/tar/

# If Scala tar is not in system, download it
ls ../../vagrant/tar/ | 
grep ^scala &> /dev/null || 
wget https://downloads.lightbend.com/scala/2.13.13/scala-2.13.13.deb -P ../../vagrant/tar/

# If Scala is not installed, install Scala
#scala -version &> /dev/null || {
#sudo dpkg -i ../../vagrant/tar/scala-2.13.13.deb
#}

# If sbt is not installed, install sbt
#sbt -version &> /dev/null || {
#echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
#echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
#curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
#sudo apt-get update
#sudo apt-get install -y sbt
#}

######################################
# INSTALL Python and pip
######################################

# If Python is not installed, install Python
python3 --version &> /dev/null || {
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-get install -y python3.10
}

# If pip is not installed, install pip
pip3 --version &> /dev/null || sudo apt-get install -y python3-pip

echo "Setup Java/Scala/Python Completed"