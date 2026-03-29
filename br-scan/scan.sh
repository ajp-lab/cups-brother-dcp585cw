#!/bin/bash
echo "🚀 Start Container..."
mkdir -p ~/Desktop/Scans
docker run -d --platform linux/amd64 --name brother-scan-test -v ~/Desktop/Scans:/output  brother-scanner
sleep 2 #Wait until driver is ready 
echo "Container started..."

echo "📸 Scan doc..."
# Zeitstempel für den Dateinamen
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="scan_$TIMESTAMP.png"

docker exec -it brother-scan-test scanimage --resolution 300 --format=png > ~/Desktop/Scans/$FILENAME

# Check if OK
if [ $? -eq 0 ]; then
    echo "--- Scan successful! File saved under: ~/Desktop/Scans/$FILENAME ---"
else
    echo "--- Error: Scanner not reachable or other error. ---"
fi
