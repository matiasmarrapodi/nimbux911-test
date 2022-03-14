#!/bin/bash

sudo su

sudo apt update -y
sudo apt install apache2 -y
echo "Apache2 install ok"
sudo service apache2 start
echo "HI NIMBUXERS THIS IS APACHE2" > /var/www/html/index.html