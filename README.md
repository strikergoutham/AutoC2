
# AutoC2

A quick C2 Deployer.

## High Level Overview

AutoC2 makes use of terraform + ansible to deploy a command and control server with isolated docker network within less than 5 mins in a single click!

Brief outline of what the script does :

1. deploys a ec2 micro instance on desired region given by user.

2. setup the C2 server which is not exposed to the internet with the help of isolated docker network which consists of multiple socat redirectors and a metasploit container instance.


These infrastructure can be setup and teardown in very limited time.
