graph TD
    subgraph Windows_Clients [Clients]
        Laptop1[Win 11 Laptop] -.->|IPP Print| Mac
        Laptop2[Win 11 Laptop] -.->|IPP Print| Mac
    end

    subgraph Server_Node [Mac Studio M4 Max]
        Mac[macOS Tahoe]
        subgraph Docker_Platform [Docker Desktop]
            direction TB
            Container[Ubuntu 22.04 Container i386]
            CUPS[CUPS Print Server]
            Drivers[Brother 32-bit Drivers]
            
            Container --- CUPS
            CUPS --- Drivers
        end
    end

    subgraph Legacy_Hardware [Printer]
        Printer((Brother DCP-585CW))
    end

    Mac --- Docker_Platform
    Drivers -.->|Socket/LPD 192.168.1.xxx| Printer

    style Mac fill:#f9f,stroke:#333,stroke-width:2px
    style Docker_Platform fill:#0db7ed,stroke:#fff,color:#fff
    style Printer fill:#fff,stroke:#333,stroke-dasharray: 5 5
