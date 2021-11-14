# Nginx and other Services in Docker

## Klad

- Proxyserver
- Website
- MySQL 3306
- Wordpress 80 domainnaam mywordpress.

## Intro

In deployment of your services to the cloud you want as little dependencies as possible 
on the host systems you are depeloying to.

Just get a Droplet from Digital Ocean, an EC2 from AWS or get your own box with bare Ubuntu
in a rack somewhere.

Then get the software from your github account, 
run a start script and everything should go from there.

This document shows how such a setup could look like.

It explains the following concepts and techniques:
- How to put Nginx in a Docker Container
- How to do the Docker networking to tie everything together
- Using SSL in Ngix in Docker
- How to set up databases MySQL, Postgress, MongoDB
- How to install Wordpress website, HTML website, NodeJS API, and React Frontend
- How to set up SFTP 
- How to set up SMTP Email Server to be used by the other services

A lot of topics and you can cherrypick what you need from it. 
The core of the project is a Nginx Proxyserver project running in a Docker Container

This explanation does all the steps starting from scratch. 
You can follow along (and actually learn something :-) ) or
(be lazy and) git-clone the whole repo from ### TODO ###

### Approach and tools

The approach to achieve this is Docker. 
The host system, being a Digital Ocean Droplet, 
an AWS EC2 system or your own old laptop running Ubuntu.
All they need is Docker (and docker-compose) installed 
and a few open ports on the firewall.

We're using
- The Linux system, wherever you get this from
- Nginx
- SSL
- DNS (for the domains)
- Bit-of-Bash

### Advantage

The advantage of this approach is that you're totally flexible where to deploy your services.
The complete Deployment of all of your services is stored in a project itself.

### What you already need to know
This article expect you already know a bit about:
- bash shell scripting
- docker and docker-compose on a beginners level
- dns, ssl and basic networking stuff on Unix

## Setting up the environment
The complete environment is a project in itself. 

Create a folder/directory (lets stick to the OSX terminology since this article is created on OSX)
somewhere on your dev machine:
```bash
mkdir deployProject
```
In there all the services and the proxyserver each have
their own folder.


## Docker Network
Since each servce gets its own docker-compose.yml file but they
all need to talk to each other, we need to use an external 
Docker Network. 

An external docker network is a network created outside some
docker-compose file. In the compose file you 'attach' to that 
network. 

Therefore you need to make sure it is already created before 
running the first compose file. 

### create_network.sh
Create a create_network.sh file with the following contents:
```bash
#! /bin/bash

docker network create --driver=bridge --subnet=172.30.0.0/16 --ip-range=172.30.0.0/24 --gateway=172.30.0.1 my-net
```
- --driver=bridge, [Allows containers connected to the same bridge network to communicate](https://docs.docker.com/network/bridge/).
- --subnet=127.30.0.0/16, 

  This defines the network itself. In this case from 127.30.0.0 to 127.30.255.255. (The "/16" means: the last 16 bits may vary)
- --ip-range=172.30.0.0/16, Containers can use IP addresses within this range
- --gateway=172.30.0.1, The gateway to this network is this address. Meaning: Everything goes via this address.

Set the correct permissions on the create_network.sh file and run it
```bash
$ chmod +x create_network.sh 

$ ./create_network.sh 
1f5f0af217c5642fe146a2f4f31ee26bbd267cd77206e50f79a2cc7c4d33fbd2

$ docker network ls
NETWORK ID     NAME                 DRIVER    SCOPE
05edd37872ae   bridge               bridge    local
34ec89b76309   deployment_default   bridge    local
c3d54e8a6716   host                 host      local
646c86930e37   my-net               bridge    local
98e8b6a26fcc   none                 null      local
```

## Setting up the ProxyServer
Let's start off easy with a bare proxyserver 
and a very simple website.

```bash
cd deployProject
mkdir proxyserver
```

### docker-compose.yml for the ProxyServer
In the proxyserver folder create a file called docker-compose.yml. 
Below the full file and we walk through it by section:


# HIER GEBLEVEN







## 3 Containers

- Deployment
- WebA
- WebB

### Deployment

This is the Nginx container doing all the forwarding to other containers.

### WebA and WebB

There are simple websites, running also nginx.

But they can also be NodeJS API's or a React App.

## Logfiles

Each website leaves their Nginx logfiles in the specific logs directory.

## Setup on Host

### Add the extra sites in host file

Create the following 2 lines in /etc/hosts on the Host:

```bash
127.0.0.1   a.xx.bert
127.0.0.1   b.xx.bert
```

Or you have them already in DNS of course...

### Start the Docker-compose file

```bash
docker-compose up -d
```

## Want more info?

Place an issue if you're interesed in more info on this, or extra functionality, and I'll add that to this Repo.
