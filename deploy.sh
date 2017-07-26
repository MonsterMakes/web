#!/bin/sh
echo "*** STARTING DEPLOYMENT ***";
ssh -oStrictHostKeyChecking=no -i id_rsa monster@monstermakes.tech;
ll;
echo "*** DEPLOYMENT COMPLETE ***";
exit;
