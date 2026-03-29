#!/bin/bash
echo "🧹 Cleanup old container and image..."
docker stop brother-scan-test
docker rm brother-scan-test 2>/dev/null
docker rmi brother-scanner 2>/dev/null

echo "🏗️ Build new Scanner-Image..."
docker build --no-cache --platform linux/amd64 -t brother-scanner .
echo "✅ Ready"
