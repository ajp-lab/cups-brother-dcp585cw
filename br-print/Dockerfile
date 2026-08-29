FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Systempakete & 32-Bit-Abhängigkeiten
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    cups \
    cups-client \
    cups-bsd \
    cups-filters \
    ghostscript \
    poppler-utils \
    qemu-user-static \
    libc6:i386 \
    libstdc++6:i386 \
    file \
    a2ps \
    psutils \
    csh \
    net-tools \
    iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# 2. Treiber aus dem lokalen drivers-Ordner kopieren & installieren
WORKDIR /tmp
COPY drivers/*.deb /tmp/

RUN dpkg -i --force-all /tmp/dcp585cwlpr-1.1.2-2.i386.deb && \
    dpkg -i --force-all /tmp/dcp585cwcupswrapper-1.1.2-2.i386.deb && \
    rm -f /tmp/*.deb

# 3. Symlinks setzen
#RUN ln -sf /usr/local/Brother/Printer/dcp585cw/lpd/brdcp585cwfilter /usr/lib/cups/filter/brdcp585cwfilter && \
#    ln -sf /usr/local/Brother/Printer/dcp585cw/cupswrapper/brcupsconfig3 /usr/bin/brcupsconfig3 2>/dev/null || true

# 4. CUPS-Konfiguration
RUN sed -i 's/Listen localhost:631/Listen 0.0.0.0:631/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/>/<Location \/>\n  Allow all/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/admin>/<Location \/admin>\n  Allow all/' /etc/cups/cupsd.conf && \
    echo "ServerAlias *" >> /etc/cups/cupsd.conf

EXPOSE 631

CMD ["/usr/sbin/cupsd", "-F"]
