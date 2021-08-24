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
