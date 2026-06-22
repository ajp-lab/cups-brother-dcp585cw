# Architektur-Fix für Apple Silicon (M4 Max)
FROM ubuntu:22.04

# 1. Nur die absolut kritischen Werkzeuge und die 32-Bit-Architektur vorbereiten
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
    wget ca-certificates sudo cups sane-utils curl \
    && mkdir -p /etc/udev/rules.d \
    && rm -rf /var/lib/apt/lists/*

# 2. Brother Tool vorbereiten (v. 2.2.6-0) fuer DCP-585CW printer
WORKDIR /tmp
RUN wget https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.6-0.gz && \
    gunzip linux-brprinter-installer-2.2.6-0.gz && \
    chmod +x linux-brprinter-installer-2.2.6-0

# 3. Das Tool mit "Pipe-Feeding" ausführen
# Wir senden die Antworten als Sequenz:
# DCP-585CW (Modell) -> y (Download) -> y (Lizenz) -> y (OK) 
# -> n (KEINE Testseite drucken!) -> y (Scanner Konfig) 
# -> 11 (Auswahl IP-Adresse) -> 192.168.50.10 (Die IP) -> y (Bestätigen)
#RUN printf "DCP-585CW\ny\ny\ny\nn\ny\n11\n192.168.50.10\ny\n" | bash linux-brprinter-installer-2.2.6-0

WORKDIR /output
CMD ["tail", "-f", "/dev/null"]


