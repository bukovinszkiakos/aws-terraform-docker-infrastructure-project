#!/bin/bash

apt update -y
apt install -y docker.io docker-compose awscli

systemctl start docker
systemctl enable docker

mkdir -p /home/ubuntu/app
cd /home/ubuntu/app

aws ecr get-login-password --region eu-central-1 \
| docker login --username AWS --password-stdin ${ecr_repo_url}

cat <<EOF > docker-compose.yml
version: '3'

services:

  app1:
    image: ${ecr_repo_url}:latest
    restart: always

  app2:
    image: ${ecr_repo_url}:latest
    restart: always

  nginx:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - app1
      - app2
EOF


cat <<EOF > nginx.conf
events {}

http {

    upstream whale_backend {
        server app1:80;
        server app2:80;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://whale_backend;
        }
    }
}
EOF

docker-compose up -d