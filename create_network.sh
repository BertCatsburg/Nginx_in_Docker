#!/bin/bash

docker network create --driver=bridge --subnet=172.30.0.0/16 --ip-range=172.30.0.0/16 --gateway=172.30.0.1 my-net
