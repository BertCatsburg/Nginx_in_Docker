#!/bin/bash

cd mysql
docker-compose up -d

cd ../staticwebsite
docker-compose up -d

cd ../wordpress
docker-compose up -d

cd ../proxyserver
docker-compose up -d

cd ..
