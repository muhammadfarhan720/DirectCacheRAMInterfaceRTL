// Cache and RAM datapath

module Memory_datapath(
  globalclock, reset, wrEn, address, hit, outData_cache,memOut
);
    input globalclock, reset, wrEn;
    input[14:0] address;
    output hit;
    output[31:0] outData_cache;
    output [127:0] memOut;
    wire[127:0] memOut;

    Cache CACH(.globalclock(globalclock), .reset(reset), .wrEn(wrEn), .address(address), .inData(memOut), .outData_cache(outData_cache), .hit(hit));
    MainMemory MM(.address(address[14:2]), .outData_mem(memOut));

endmodule 
