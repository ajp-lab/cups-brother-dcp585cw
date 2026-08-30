FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. System packages and 32 bit dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    cups \
    cups-client \
    cups-bsd \
    cups-filters \
    sane-utils \
    ghostscript \
    poppler-utils \
    qemu-user-static \
    libc6:i386 \
    libstdc++6:i386 \
    libusb-0.1-4 \
    file \
    a2ps \
    psutils \
    csh \
    net-tools \
    iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# 2. Copy Brother DCP-585CW libs from local folder and install them
WORKDIR /tmp
COPY drivers/*.deb /tmp/

RUN dpkg -i --force-all /tmp/dcp585cwlpr-1.1.2-2.i386.deb && \
    dpkg -i --force-all /tmp/dcp585cwcupswrapper-1.1.2-2.i386.deb && \
    dpkg -i --force-all /tmp/brscan3-0.2.13-1.amd64.deb && \
    dpkg -i --force-all /tmp/brscan-skey-0.3.4-0.amd64.deb && \
    rm -f /tmp/*.deb

# 3. Symlinks set
# FIX: 32-Bit-Decoder-Lib to be copied to the path expected from SANE
RUN cp -a /usr/lib64/libbrscandec3.so* /usr/lib/ 2>/dev/null || true && \
    ldconfig

# 4. CUPS-Configuration
RUN sed -i 's/Listen localhost:631/Listen 0.0.0.0:631/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/>/<Location \/>\n  Allow all/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/admin>/<Location \/admin>\n  Allow all/' /etc/cups/cupsd.conf && \
    echo "ServerAlias *" >> /etc/cups/cupsd.conf

EXPOSE 631

CMD ["/usr/sbin/cupsd", "-F"]
