#!/bin/sh
ssh -oStrictHostKeyChecking=no -i id_rsa monster@monstermakes.tech << EOF
  echo "*** STARTING DEPLOYMENT ***";
  echo "Pulling Docker Container..."
  docker stop web
  docker rm web
  docker pull lockenj/web
  echo "Deploying Docker Container..."
  docker run --name web -dit -p 80:81 --restart unless-stopped lockenj/web
  echo "*** DEPLOYMENT COMPLETE ***"
  exit
EOF
