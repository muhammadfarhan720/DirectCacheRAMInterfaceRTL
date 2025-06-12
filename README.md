# DirectCacheRAMInterfaceRTL
This project involves the RTL design and verification of a direct-mapped cache memory system integrated with RAM and a control unit, implemented using Xilinx Vivado. The system supports a 15-bit address input, managing a 128-bit cache line with 1024 entries.


![Cache_controller_synthesis (1)](https://github.com/user-attachments/assets/1fd2247e-335b-4b65-ac5b-6853482763b3)


## Important functionality

- **Hit/Miss Logic**  
  - Tag-bits + valid-bit comparison in one cycle  
  - Configurable write-back on eviction

- **Handshake Protocol**  
  - Two-phase `req`/`ack` ensures no data hazards  
  - Back-to-back transfers supported via pipelined signals

## Key Features

- **Cache Architecture:**  
  - Direct-mapped cache with 1024 entries, each storing a 128-bit data line.


- **Address Handling:**  
  - 15-bit address input mapped to cache lines for seamless memory access.


- **Control Unit:**  
  - FSM-based controller to orchestrate cache operations, including hit/miss detection and data synchronization.


- **Synchronization:**  
  -  Read/write handshake signals ensure efficient cache-RAM communication.

 
- **Verification:**  
  -  Thorough validation using Xilinx Vivado, confirming design reliability and performance.


## Cache mapping architecture 

![Direct_mapping](https://github.com/user-attachments/assets/8ff5f412-7d26-43c6-8869-eb8a96fbe02f)
