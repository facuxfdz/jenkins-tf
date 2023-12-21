#!groovy

import hudson.security.*
import jenkins.model.*
import jenkins.install.InstallState

def instance = Jenkins.getInstance()

println "Disabling login for instance: ${instance}"

def username = "admin"
def password = "admin123"

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