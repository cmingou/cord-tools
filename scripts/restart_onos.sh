#!/bin/bash
cd /home/ubuntu/onos-fabric/
docker-compose stop
docker-compose rm -f
docker-compose up -d

cd /home/ubuntu/onos-cord/
docker-compose stop
docker-compose rm -f
docker-compose up -d
