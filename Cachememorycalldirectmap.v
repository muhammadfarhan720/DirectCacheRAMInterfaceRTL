`timescale 1ns / 1ps

//This is the top module of the design 

module Cachememorycalldirectmap(

 globalclock, reset, start, done, wrEn, address, outData_cache, memOut
 
);
    input globalclock, reset, start;
    input[14:0] address;
    input  wrEn;
    output done;
 
    output[31:0] outData_cache;
    output [127:0] memOut;
    wire hit;
    
    Memory_datapath DP(.globalclock(globalclock), .reset(reset), .wrEn(wrEn), .address(address), .hit(hit), .outData_cache(outData_cache), .memOut(memOut));
    Control_unit CU(.globalclock(globalclock), .reset(reset), .start(start), .done(done), .address(address), .wrEn(wrEn), .hit(hit));
 
endmodule 

