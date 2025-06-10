// Extracting data from the selected Cache block offset

module Cache(
  globalclock, reset, wrEn, address, inData, outData_cache, hit
);
    input globalclock, reset, wrEn;
    input[14:0] address;
    input[127:0] inData;
    output hit;
    output[31:0] outData_cache;
    wire[127:0] CDMOut;
    wire[2:0] tagOut;
    wire isValid;

    CacheDataMemory CDM(.globalclock(globalclock), .reset(reset), .wrEn(wrEn), .address(address[11:2]), .inData(inData), .outData_cache(CDMOut));
    VMemory VM(.globalclock(globalclock), .reset(reset), .wrEn(wrEn), .address(address[11:2]), .inValidity(1'b1), .isValid(isValid));
    TagMemory TM(.globalclock(globalclock), .reset(reset), .wrEn(wrEn), .address(address[11:2]), .inData(address[14:12]), .outData(tagOut));
    assign hit = (isValid) && (tagOut == address[14:12]);
 
    begin
    assign outData_cache = (address[1:0] == 2'b00) ? CDMOut[127:96] :
                     (address[1:0] == 2'b01) ? CDMOut[95:64] :
                     (address[1:0] == 2'b10) ? CDMOut[63:32] :
                     (address[1:0] == 2'b11) ? CDMOut[31:0]: 32'b0;
    end
    

endmodule 