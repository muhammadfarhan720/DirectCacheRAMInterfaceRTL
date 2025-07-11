# DirectCacheRAMInterfaceRTL
This project involves the RTL design and verification of a direct-mapped cache memory system integrated with RAM and a control unit, implemented using Xilinx Vivado. The system supports a 15-bit address input, managing a 128-bit cache line with 1024 entries.

# Architecture Top view (Vivado Schematic)

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
     - Selects one of 1024 cache lines in both tag and data arrays  
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


## Verification & Testing

The cache interface was tested and verified in Xilinx Vivado Simulator using a SystemVerilog testbench. RAM contents were pre-initialized so each address holds its own index value, and a global clock/reset was driven from the testbench. Coverage focused on:

- **Address Mapping**  
  Mapping all 32,768 RAM entries into 1 024 cache lines via 10-bit index and 3-bit tag.
- **Hit/Miss Behavior**  
  Correct detection of cold misses, cache hits after refill, and write-back on dirty eviction.
- **Handshake Protocol**  
  Two-phase `cpu_req`/`cpu_ack` and `ram_req`/`ram_ack` sequencing without overlap.
- **FSM State Transitions**  
  Exercising IDLE → COMPARE → {HIT, MISS_FETCH → REFILL → IDLE, WRITEBACK}.
- **Block-Offset Muxing**  
  4:1 selection of 32-bit words (offset 0–3) within each 128-bit line.
- **Valid/Dirty Flags**  
  Proper setting on refill, clearing on reset, and dirty-bit behavior on writes.

### Test Cases

- **Cold Miss at Address 0**  
  – First access to `addr = 0`: expect miss, RAM fetch, refill, valid bit set, data returned.  
- **Hit After Refill**  
  – Re-access `addr = 0`: expect one-cycle hit.  
- **High-Address Access**  
  – `addr = 30,770` : verify correct line fetch and word-offset selection.  
- **Sequential Collision & Eviction**  
  – Access two addresses sharing the same index: dirty-line eviction triggers write-back before refill.  
- **Write + Readback**  
  – Write a new value to a cache line, then read it back to validate dirty-bit logic.  
- **Offset Coverage**  
  – Access same cache line with offsets 0, 1, 2, 3 to confirm 4:1 word mux.


### Video : Overview and Verification testing 

[![Thumbnail for video demo](https://raw.githubusercontent.com/muhammadfarhan720/DirectCacheRAMInterfaceRTL/main/Image/Timing_diagram_cache.jpg)](https://drive.google.com/file/d/194-agafBoxZ01dm_yz42LCh1Bm7x_wFZ/view?usp=sharing)

*Click the thumbnail to see the overview demo of the Cache-Ram memory hierarchy architecture and it's verification*
