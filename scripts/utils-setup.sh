#!/bin/bash 

echo "Setup Java/Scala/Python"

######################################
# INSTALL JDK
######################################

# If jdk is not installed, install OpenJDK 8
java -version &> /dev/null || {
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
sudo apt-get install net-tools
}

# Set environmental variables
grep JAVA .bashrc &> /dev/null || cat >> .bashrc << 'EOF'

# JAVA Variables START
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
# JAVA Variables END
EOF

######################################
# INSTALL Scala and sbt
######################################

# Make tar folder if it doesn't exist
mkdir -p ../../vagrant/tar/

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