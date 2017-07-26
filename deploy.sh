#!/bin/sh
echo "*** STARTING DEPLOYMENT ***";
ssh -i id_rsa monster@monstermakes.tech;
ll;
echo "*** DEPLOYMENT COMPLETE ***";
exit;
