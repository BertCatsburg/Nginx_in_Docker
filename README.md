# Nginx in Docker

## Klad

- Proxyserver
- Website
- MySQL 3306
- Wordpress 80 domainnaam mywordpress.

## Intro

In deployment of your services in the cloud you want as little dependencies as possible 
to the host systems you are depeloying on.

Just get a Droplet from Digital Ocean, an EC2 from AWS or get your own box with bare Ubuntu
in a rack somewhere.

Then get the software from your gisthub account, run a start script and everyyhing 
should go from there.

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

### Approach

The approach to achieve this is Docker. The host system, being a Digital Ocean
Droplet, an AWS EC2 system or your own old laptop running Ubuntu, they all only need Docker (and docker-compose), open a
few ports on the firewall and that's it.

### Advantage

The advantage of this approach is that you're totally flexible where to deploy your services.
The complete Deployment of all of your services is stored in a project itself.

## Setting up the ProxyServer
Let's start off easy: Setting up the Project itself with bare proxyserver and a very simple website




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
