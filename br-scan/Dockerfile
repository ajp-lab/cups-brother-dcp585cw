# 1. Basis: 32-Bit Debian Bullseye
FROM --platform=linux/386 i386/debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# 2. Pakete für SANE & Netzwerk
RUN apt-get update && apt-get install -y --no-install-recommends \
    iputils-ping \
    sane \
    sane-utils \
    wget \
    ca-certificates \
    libusb-0.1-4 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Brother Scan-Treiber über den neuen Link laden
WORKDIR /tmp
RUN wget http://www.brother.com/pub/bsc/linux/dlf/brscan3-0.2.11-4.i386.deb && \
    dpkg -i --force-all brscan3-0.2.11-4.i386.deb

# 4. Den Netzwerk-Scanner registrieren
RUN brsaneconfig3 -a name=Brother_Scanner model=DCP-585CW ip=192.168.50.10

# 5. Start-Script
CMD ["tail", "-f", "/dev/null"]
