#!/bin/bash
# Startet den Container voll privilegiert, falls er nicht läuft
docker start brother_tool 2>/dev/null || docker run -d \
  --name brother_tool \
  --privileged \
  --net=host \
  -v ~/Desktop/Scans:/output \
  brother-base

# Führt den eigentlichen Scan-Befehl aus
#docker exec brother_scanner scanimage --resolution 300 --format=jpeg > ~/Desktop/Scans/scan_$(date +%Y%m%d_%H%M%S).jpg
