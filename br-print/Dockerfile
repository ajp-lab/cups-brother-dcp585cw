# 1. Basis: Echtes 32-Bit Debian Bullseye
FROM --platform=linux/386 i386/debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# 2. System-Pakete & 32-Bit Libs (Inklusive a2ps für Filter-Support)
RUN apt-get update && apt-get install -y --no-install-recommends \
    cups \
    cups-client \
    ghostscript \
    wget \
    ca-certificates \
    libcupsimage2 \
    libpng16-16 \
    perl \
    libc6 \
    libncurses5 \
    libstdc++6 \
    sudo \
    a2ps \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. User & Gruppen (User: admin | PW: brother)
RUN useradd -m -G lpadmin -s /bin/bash admin && \
    echo "admin:brother" | chpasswd

# 4. Brother Treiber Installation
WORKDIR /tmp
RUN mkdir -p /var/spool/lpd /usr/share/cups/model /etc/cups/ppd /usr/lib/cups/filter
RUN wget --no-check-certificate https://download.brother.com/welcome/dlf005515/dcp585cwlpr-1.1.2-2.i386.deb && \
    wget --no-check-certificate https://download.brother.com/welcome/dlf005517/dcp585cwcupswrapper-1.1.2-2.i386.deb && \
    dpkg -i --force-all dcp585cwlpr-1.1.2-2.i386.deb && \
    dpkg -i --force-all dcp585cwcupswrapper-1.1.2-2.i386.deb

# 5. CUPS Konfiguration (Basic Auth wieder AKTIVIERT für den Browser)
RUN echo "Port 631\n\
Browsing On\n\
BrowseLocalProtocols dnssd\n\
DefaultAuthType Basic\n\
WebInterface Yes\n\
<Location />\n\
  Order allow,deny\n\
  Allow All\n\
</Location>\n\
<Location /admin>\n\
  Order allow,deny\n\
  Allow All\n\
</Location>\n\
<Location /admin/conf>\n\
  AuthType Basic\n\
  Require user @lpadmin\n\
  Order allow,deny\n\
  Allow All\n\
</Location>\n\
ServerAlias *\n\
DefaultEncryption Never" > /etc/cups/cupsd.conf

EXPOSE 631

# 6. Start-Script (Wir nutzen den Root-Bypass für lpadmin)
CMD service cups start && \
    sleep 3 && \
    # Berechtigungs-Fix für die Brother-Filter
    chmod 755 /usr/lib/cups/filter/* && \
    # Drucker-Setup (Wir ignorieren Fehler, falls er schon existiert)
    REAL_PPD=$(find /usr/share/cups/model -name "*.ppd" | head -n 1) && \
    lpadmin -p DCP585CW -E -v socket://192.168.50.10 -P "$REAL_PPD" && \
    echo "Drucker bereit unter: http://localhost:6310" && \
    /usr/sbin/cupsd -f
