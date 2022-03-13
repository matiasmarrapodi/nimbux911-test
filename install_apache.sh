#!/bin/bash

sudo su

sudo apt update -y
sudo apt install apache2 -y
echo "Apache2 install ok"
sudo service apache2 start
echo "Hello World from $(hostname -f)" > /var/www/html/index.html