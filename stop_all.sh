#!/bin/bash

cd mysql
docker-compose down

cd ../proxyserver
docker-compose down

cd ../staticwebsite
docker-compose down

cd ../wordpress
docker-compose down

cd ..
