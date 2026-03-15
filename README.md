```mermaid
graph TD
    A[Mac Studio M4 Max] -->|LAN| B(Docker Container)
    subgraph "Docker (Ubuntu i386 Emulation)"
    B --> C[CUPS Druckerserver]
    C --> D[Brother LPR Treiber]
    D --> E[CUPSwrapper Treiber]
    end
    E -->|LAN| F[Brother DCP-585CW]
