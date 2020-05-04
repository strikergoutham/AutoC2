
# AutoC2

A quick isolated C2 Deployer.

## Overview

AutoC2 makes use of terraform + ansible to deploy and hide a command and control server with isolated docker network within less than 5 mins in a single click!

Brief outline of what the script does :

1. deploys a ec2 micro instance on desired region given by user.

2. setup the C2 server which is not exposed to the internet with the help of isolated docker network which consists of multiple socat redirectors and a metasploit container instance.

3. uses meterpreter_reverse_http as payload and similar payloads such as 
meterpreter_reverse_https and meterpreter_reverse_tcp works as well. (requires modification to docker_delivery.rc file)



These infrastructure can be setup and teardown in very limited time.

## Prerequisites

* terraform must be installed
* ansible(python 3)must be installed.
* your IAM account credentials (Aws access key and secret key) with admin privileges.
* AWS Region to be deployed and image(tested on ubuntu and works on debain) AMI code.

