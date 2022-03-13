#!/bin/bash
echo "* Installing nginx"
sudo apt update -y
sudo apt install nginx -y
echo "* Completed Installing nginx"
sudo service nginx start