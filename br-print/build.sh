#!/bin/bash
echo "🧹 Cleanup old container and image..."
docker stop brother-cups
docker rm brother-cups 2>/dev/null
docker rmi brother-printer 2>/dev/null

echo "🏗️ Build new printer image..."
docker build --no-cache --platform linux/386 -t brother-printer .
echo "✅ Ready"
