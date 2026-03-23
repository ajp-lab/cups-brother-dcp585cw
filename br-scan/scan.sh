#!/bin/bash
echo "🚀 Start Container..."
docker run -d --platform linux/386 --name brother-scan-test -p 54921:54921/udp -p 54925:54925/udp brother-scanner
sleep 3 #Wait until driver is ready 

echo "📸 Scan doc..."
docker exec -it brother-scan-test scanimage --device-name "brother3:net1;dev0" --format=tiff > scan_$(date +%Y%m%d_%H%M%S).tiff
