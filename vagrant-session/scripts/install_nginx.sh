#!/bin/bash

# Install nginx
echo "[TASK 1] Installing nginx - Shell provisioner"
yum install -y nginx

# Modify starting page
echo "[TASK 2] Modify nginx starting page"
echo "HOLA - Nginx setup via shell provisioner - How cool is that" > /usr/share/nginx/html/index.html

# Enable and Start nginx
echo "[TASK 3] Starting nginx"
systemctl enable --now nginx