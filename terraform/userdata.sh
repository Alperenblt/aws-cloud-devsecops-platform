#!/bin/bash
dnf install -y nginx
systemctl enable nginx
systemctl start nginx
echo "<h1>Hello from Terraform and AWS!</h1>" > /usr/share/nginx/html/index.html