#!groovy

import hudson.security.*
import jenkins.model.*
import jenkins.install.InstallState

def instance = Jenkins.getInstance()

println "Disabling login for instance: ${instance}"

def fileContents = ""
def file = new File("/tmp/jenkins_credentials.txt")
file.eachLine { line ->
    fileContents += line
}

println("File contents: ${fileContents}")
String[] lines = fileContents.split(",")
println("lines: ${lines}")
def username = lines[0]
def password = lines[1]

def hudsonRealm = new HudsonPrivateSecurityRealm(false)

hudsonRealm.createAccount(username, password)
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

if (!instance.installState.isSetupComplete()){
    println "Setting up Jenkins"
    InstallState.INITIAL_SETUP_COMPLETED.initializeState()
}

instance.save()
file.delete()