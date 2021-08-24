# Nginx in Docker

## Sources
- [Blog: Host Multiple Websites On One VPS With Docker And Nginx](https://blog.ssdnodes.com/blog/host-multiple-websites-docker-nginx/)
- [Blog: Running with jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy)



## Setup on Host
Create the following 2 lines in /etc/hosts on the Host:
```bash
127.0.0.1   a.xx.bert
127.0.0.1   b.xx.bert
```

## Possible Errors
### Go to a.xx.bert
Browser sees 502 Bad Gateway

Logfile sees:
```
web   | 2021/08/23 19:08:28 [error] 8#8: *1 connect() failed (111: Connection refused) while connecting to upstream, client: 172.23.17.1, server: a.xx.bert, request: "GET / HTTP/1.1", upstream: "http://172.23.17.3:8081/", host: "a.xx.bert"
web   | 172.23.17.1 - - [23/Aug/2021:19:08:28 +0000] "GET / HTTP/1.1" 502 157 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0) Gecko/20100101 Firefox/91.0" "-"
```

Interesting part in the error:
- **connect() failed (111: Connection refused)**
- while connecting to upstream, 
- client: 172.23.17.1, server: a.xx.bert, 
- request: "GET / HTTP/1.1", 
- upstream: "http://172.23.17.3:8081/", 
- host: "a.xx.bert"


## Jwilder Proxy
### Generated default.conf
```bash
# If we receive X-Forwarded-Proto, pass it through; otherwise, pass along the
# scheme used to connect to this server
map $http_x_forwarded_proto $proxy_x_forwarded_proto {
  default $http_x_forwarded_proto;
  ''      $scheme;
}
# If we receive X-Forwarded-Port, pass it through; otherwise, pass along the
# server port the client connected to
map $http_x_forwarded_port $proxy_x_forwarded_port {
  default $http_x_forwarded_port;
  ''      $server_port;
}
# If we receive Upgrade, set Connection to "upgrade"; otherwise, delete any
# Connection header that may have been passed to this server
map $http_upgrade $proxy_connection {
  default upgrade;
  '' close;
}
# Apply fix for very long server names
server_names_hash_bucket_size 128;
# Default dhparam
ssl_dhparam /etc/nginx/dhparam/dhparam.pem;
# Set appropriate X-Forwarded-Ssl header based on $proxy_x_forwarded_proto
map $proxy_x_forwarded_proto $proxy_x_forwarded_ssl {
  default off;
  https on;
}
gzip_types text/plain text/css application/javascript application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
log_format vhost '$host $remote_addr - $remote_user [$time_local] '
                 '"$request" $status $body_bytes_sent '
                 '"$http_referer" "$http_user_agent" '
                 '"$upstream_addr"';
access_log off;
		ssl_protocols TLSv1.2 TLSv1.3;
		ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-C
HACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384';
		ssl_prefer_server_ciphers off;
resolver 127.0.0.11;
# HTTP 1.1 support
proxy_http_version 1.1;
proxy_buffering off;
proxy_set_header Host $http_host;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection $proxy_connection;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $proxy_x_forwarded_proto;
proxy_set_header X-Forwarded-Ssl $proxy_x_forwarded_ssl;
proxy_set_header X-Forwarded-Port $proxy_x_forwarded_port;
# Mitigate httpoxy attack (see README for details)
proxy_set_header Proxy "";
server {
	server_name _; # This is just an invalid value which will never trigger on a real hostname.
	server_tokens off;
	listen 80;
	access_log /var/log/nginx/access.log vhost;
	return 503;
}
# a.xx.bert
upstream a.xx.bert {
	## Can be connected with "nginx_in_docker_default" network
	# weba
	server 192.168.32.2:8000;
}
server {
	server_name a.xx.bert;
	listen 80 ;
	access_log /var/log/nginx/access.log vhost;
	location / {
		proxy_pass http://a.xx.bert;
	}
}
```
