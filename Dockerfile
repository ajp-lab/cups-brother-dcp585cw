FROM --platform=linux/386 i386/debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# 1. Pakete installieren
RUN apt-get update && apt-get install -y --no-install-recommends \
    cups \
    cups-client \
    ghostscript \
    wget \
    ca-certificates \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# 2. User & Gruppen FIX
RUN useradd -m -G lpadmin -s /bin/bash admin && \
    echo "admin:brother" | chpasswd && \
    usermod -aG lpadmin root

# 3. Die "Ultimative" cupsd.conf
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

# 4. Brother Treiber & PPD Vorbereitung
WORKDIR /tmp
RUN mkdir -p /var/spool/lpd /usr/share/cups/model /etc/cups/ppd
RUN wget --no-check-certificate https://download.brother.com/welcome/dlf005515/dcp585cwlpr-1.1.2-2.i386.deb && \
    wget --no-check-certificate https://download.brother.com/welcome/dlf005517/dcp585cwcupswrapper-1.1.2-2.i386.deb && \
    dpkg -i --force-all dcp585cwlpr-1.1.2-2.i386.deb && \
    dpkg -i --force-all dcp585cwcupswrapper-1.1.2-2.i386.deb

# 5. Das finale Start-Script
CMD service cups start && \
    sleep 2 && \
    # Wir setzen die PPD Variable
    REAL_PPD=$(find /usr/share/cups/model -name "*.ppd" | head -n 1) && \
    cp "$REAL_PPD" /etc/cups/ppd/DCP585CW.ppd && \
    # Wir nutzen lpadmin OHNE das -u root, dafür mit -E (Enable)
    lpadmin -p DCP585CW -E -v socket://192.168.50.10 -P /etc/cups/ppd/DCP585CW.ppd && \
    echo "Drucker DCP585CW erfolgreich registriert." && \
    /usr/sbin/cupsd -f
