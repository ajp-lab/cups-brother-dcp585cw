FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. 32-Bit Architektur + QEMU User Emulation + CUPS
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    cups \
    cups-client \
    cups-bsd \
    qemu-user-static \
    libc6:i386 \
    libstdc++6:i386 \
    psutils \
    csh \
    net-tools \
    sudo \
    wget \
    iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# 2. Brother .deb-Pakete einbinden & installieren
WORKDIR /tmp
RUN wget --no-check-certificate https://download.brother.com/welcome/dlf005515/dcp585cwlpr-1.1.2-2.i386.deb && \
    wget --no-check-certificate https://download.brother.com/welcome/dlf005517/dcp585cwcupswrapper-1.1.2-2.i386.deb && \
    dpkg -i --force-all dcp585cwlpr-1.1.2-2.i386.deb && \
    dpkg -i --force-all dcp585cwcupswrapper-1.1.2-2.i386.deb

# 3. CUPS Remote-Zugriff vom Mac erlauben
RUN sed -i 's/Listen localhost:631/Listen 0.0.0.0:631/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/>/<Location \/>\n  Allow all/' /etc/cups/cupsd.conf && \
    sed -i 's/<Location \/admin>/<Location \/admin>\n  Allow all/' /etc/cups/cupsd.conf

EXPOSE 631

CMD ["/usr/sbin/cupsd", "-F"]
