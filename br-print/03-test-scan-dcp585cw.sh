#!/bin/bash
CONTAINER="cups-dcp585cw"
OUTPUT_FILE="$HOME/Downloads/testscan.png"

echo "=== 1. Verifying scanner detection ==="
docker exec -it $CONTAINER scanimage -L

echo "=== 2. Executing test scan ==="
docker exec -it $CONTAINER scanimage -d "brother3:DCP-585CW" --format=png --resolution 150 -o /tmp/testscan.png

echo "=== 3. Copying scanned file to Downloads ==="
docker cp $CONTAINER:/tmp/testscan.png "$OUTPUT_FILE"

echo "Done! Scan saved to: $OUTPUT_FILE"
