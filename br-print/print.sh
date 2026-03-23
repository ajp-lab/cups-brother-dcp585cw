#!/bin/bash
echo "🚀 Start Container for printing on port 6310..."
docker run -d --name brother-cups -p 6310:631 --restart always brother-printer
