# Architektur-Fix für M4 Max (Intel Emulation via Rosetta 2)
FROM --platform=linux/amd64 ubuntu:22.04

# 1. Multi-Architektur für 32-Bit (i386) Support aktivieren
RUN dpkg --add-architecture i386

# 2. System-Abhängigkeiten (Schlank gehalten)
# lib32stdc++6 ist essenziell, da der Brother-Treiber intern 32-bit nutzt
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    dump \
    binutils \
    ghostscript \
    cups \
    curl \   
    libusb-0.1-4 \
    sane-utils \
    lib32stdc++6 \
    && rm -rf /var/lib/apt/lists/*

# 3. Brother Treiber-Suite herunterladen und installieren
# Scanner (64-bit), LPR (32-bit), CUPS-Wrapper (32-bit)
RUN wget https://download.brother.com/welcome/dlf006642/brscan3-0.2.13-1.amd64.deb -O /tmp/brscan3.deb && \
    wget https://download.brother.com/welcome/dlf005515/dcp585cwlpr-1.1.2-2.i386.deb -O /tmp/lpr.deb && \
    wget https://download.brother.com/welcome/dlf005517/dcp585cwcupswrapper-1.1.2-2.i386.deb -O /tmp/cups.deb && \
    dpkg -i --force-all /tmp/brscan3.deb && \
    dpkg -i --force-all /tmp/lpr.deb && \
    dpkg -i --force-all /tmp/cups.deb && \
    rm /tmp/*.deb

# 4. Scanner im Netzwerk registrieren
# Die IP ist fest hinterlegt für deinen DCP-585CW
RUN brsaneconfig3 -a name=DCP585CW model=DCP-585CW ip=192.168.50.10

# 5. Arbeitsumgebung definieren
RUN mkdir -p /output && chmod 777 /output
WORKDIR /output

# Container am Leben erhalten, ohne Ressourcen zu fressen
CMD ["tail", "-f", "/dev/null"]
