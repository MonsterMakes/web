#!/bin/sh
echo "*** STARTING DEPLOYMENT ***";
ssh -oStrictHostKeyChecking=no -i id_rsa monster@monstermakes.tech << EOF
  sleep 1
  echo "Pulling Docker Container..."
  docker pull lockenj/web
  echo "Deploying Docker Container..."
  docker run --name web -dit -p 80:81 --restart unless-stopped lockenj/web
  echo "*** DEPLOYMENT COMPLETE ***"
  exit
EOF
