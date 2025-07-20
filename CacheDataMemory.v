// Mapping the data of the given RAM address inside Cache line block

module CacheDataMemory(
  globalclock, reset, wrEn, address, inData, outData_cache
);
    input globalclock, reset, wrEn;
    input[9:0] address;
    input[127:0] inData;
    output[127:0] outData_cache;

    reg[127:0] dataArray[1023:0];
    integer i;

    always @(posedge globalclock) begin
      if (reset)
       begin
        for (i = 0; i < 1024; i = i + 1) begin
          dataArray[i] <= 128'b0;
        end
      end
      else
       begin
        if (wrEn)
         begin
          dataArray[address] <= inData;
        end
      end
    end
    assign outData_cache = dataArray[address];
endmodule 
