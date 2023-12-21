#!/bin/bash
sudo apt-get update -y
sudo apt-get install fontconfig openjdk-17-jre -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
    
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
            
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins


# wget http://localhost:8080/jnlpJars/jenkins-cli.jar || true
# JENKINS_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
# echo $JENKINS_PASS

# java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin configuration-as-code -auth admin:$JENKINS_PASS -restart || true