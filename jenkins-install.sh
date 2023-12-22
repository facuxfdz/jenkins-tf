#!/bin/bash
sudo apt-get update -y
sudo apt-get install fontconfig openjdk-17-jre -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
    
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
            

JENKINS_USERNAME=$1
JENKINS_PASSWORD=$2
JENKINS_PLUGINS=$3

echo "$JENKINS_USERNAME,$JENKINS_PASSWORD" > /tmp/jenkins_credentials.txt
echo "$JENKINS_PLUGINS" > /tmp/jenkins_plugins.txt

sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins