#!/bin/bash
CONTAINER="cups-dcp585cw"
PRINTER_IP="192.168.50.10"

echo "=== 1. Adding printer to CUPS ==="
docker exec -it $CONTAINER lpadmin -p DCP585CW -E -v lpd://$PRINTER_IP/BINARY_P1 -P /usr/share/cups/model/brdcp585cw.ppd

echo "=== 2. Registering scanner with SANE ==="
docker exec -it $CONTAINER brsaneconfig3 -a name=DCP-585CW model=DCP-585CW ip=$PRINTER_IP

echo "Setup completed successfully!"
