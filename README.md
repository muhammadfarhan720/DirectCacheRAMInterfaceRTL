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


1. **Address Partitioning (15-bit input)**
   - **Tag (MSBs)**  
     - Width: 3 bits (bits 14–12)  
     - Used to compare against stored tags for hit/miss decision  
   - **Index**  
     - Width: 10 bits (bits 11–2)  
     - Selects one of 1 024 cache lines in both tag and data arrays  
   - **Block Offset (LSBs)**  
     - Width: 2 bits (bits 1–0)  
     - Chooses which 32-bit word within the 128-bit cache line is returned 

2. **Tag Array**
   - Depth: 1024 entries  
   - Each entry holds:
     - 3-bit tag  
     - 1-bit valid flag  
     - (Optional) 1-bit dirty flag for write-back support  
   - On each access:
     - Read tag & valid bit at indexed entry  
     - Compare read tag to address tag → generate “tag_cmp”  
     - Hit = (`tag_cmp` && `valid`)  

3. **Data Array**
   - Depth: 1 024 entries  
   - Each entry width: 128 bits (4 × 32-bit words)  
   - On a **hit**:
     - Data word at (index, offset) is selected via a 4-to-1 word mux  
   - On a **miss**:
     - Full 128-bit line is fetched from RAM, written into this array

4. **Hit/Miss Determination & Muxing**
   - **Hit Logic**  
     ```verilog
     hit = (tag_array[index].tag == addr_tag) && tag_array[index].valid;
     ```  
   - **Data Mux**  
     - 4:1 word‐level mux selects one 32-bit word from the 128 bits based on `addr_offset`  
     - Provides CPU read data in one cycle on a hit

