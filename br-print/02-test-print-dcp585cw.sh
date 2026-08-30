#!/bin/bash
CONTAINER="cups-dcp585cw"

echo "=== Sending test print job ==="
docker exec -it $CONTAINER lp -d DCP585CW /etc/hosts
