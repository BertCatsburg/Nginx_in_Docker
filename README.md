# Nginx in Docker

## 3 Containers

- Deployment
- WebA
- WebB

### Deployment
This is the Nginx container doing all the forwarding to other containers.

### WebA and WebB
There are simple websites, running also nginx. 

But they can also be NodeJS API's or a React App.

## Setup on Host
Create the following 2 lines in /etc/hosts on the Host:
```bash
127.0.0.1   a.xx.bert
127.0.0.1   b.xx.bert
```
