# Brother DCP-585CW Revival with a Containerized Docker Solution

## Project Vision
This project aims to bridge the gap between cutting-edge hardware and legacy peripherals. Operating on a **modern Apple Silicon (M4 Max)** system, I am utilizing **Docker and x86 emulation** to breathe new life into a vintage **Brother DCP-585CW** printer and scanner.

By containerizing the original 32-bit Linux drivers within a CUPS (Common Unix Printing System) and SANE (Scanner Access Now Easy) environment, we can maintain full printing and scanning functionality on the latest macOS versions. This approach promotes **sustainability** by keeping perfectly functional hardware in service, avoiding unnecessary electronic waste.

## Architecture

```mermaid
graph TD
    A[Host Machine / Apple Silicon] -->|Local Port 6310| B(Docker Container)
    subgraph "Docker (Ubuntu 22.04 amd64/i386)"
    B --> C[CUPS Print Server & SANE]
    C --> D[Brother LPR & brscan3 Drivers]
    D --> E[CUPSwrapper & 32-bit Decoder]
    end
    E -->|Network LPD / UDP| F[Brother DCP-585CW]


## Prerequisites  
Docker and Docker Compose installed.  
A static IP address assigned to your Brother DCP-585CW printer in your local router setup (e.g., 192.168.50.10).

The official Brother .deb driver packages are already downloaded and placed inside the ./drivers/ folder:

- dcp585cwlpr-1.1.2-2.i386.deb
- dcp585cwcupswrapper-1.1.2-2.i386.deb
- brscan3-0.2.13-1.amd64.deb
- brscan-skey-0.3.2-0.amd64.deb

## Getting Started

1. Build and Start the Container
Run Docker Compose to build the image with all required 32-bit compatibility libraries and start the container in the background:

Bash
docker compose up -d --build

2. Configure Static IP & Run Setup
Make all helper scripts executable:

Bash
chmod +x 01-setup-dcp585cw.sh 02-test-print-dcp585cw.sh 03-test-scan-dcp585cw.sh

Ensure the IP address in 01-setup-dcp585cw.sh matches your printer's static IP (default: 192.168.50.10), if not, change it.
Then execute the setup script:

Bash
./01-setup-dcp585cw.sh

This script provisions the print queue in CUPS and registers the network scanner device in SANE.

## Testing Functionality
Since the device handles print and scan operations independently, tests are separated into two dedicated scripts:

Test Printing
Sends a test print job (/etc/hosts) to the CUPS spooler:

Bash
./02-test-print-dcp585cw.sh

Test Scanning
Verifies scanner detection, performs a 150 DPI PNG scan, and copies the resulting image directly to your local ~/Downloads/ directory:

Bash
./03-test-scan-dcp585cw.sh

## Web Interface
You can access the CUPS Web Administration panel at:

http://localhost:6310

## Technical Highlights & Troubleshooting
- 32-Bit SANE Decoder Path Fix: The Brother 64-bit SANE backend specifically looks for libbrscandec3.so in /usr/lib/. The Dockerfile automatically copies this file from /usr/lib64/ to /usr/lib/ during the image build to avoid Invalid argument errors during scanning.

- Port Mapping: CUPS is exposed on host port 6310 to prevent port conflicts with native CUPS services running on the host system.

We wish you a great experience with this project and your dcp-585cw Brother printer model.
Best, ajp-lab









