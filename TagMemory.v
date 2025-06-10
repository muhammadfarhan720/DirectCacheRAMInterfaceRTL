// Tag bits of cache lines

module TagMemory(
  globalclock, reset, wrEn, address, inData, outData
);
    input globalclock, reset, wrEn;
    input[9:0] address;
    input[2:0] inData;
    output[2:0] outData;

    reg[2:0] tagArray[1023:0];
    integer i;

    always @(posedge globalclock )
     begin
      if (reset) 
      begin
        for (i = 0; i < 1024; i = i + 1) begin
          tagArray[i] <= 3'b0;
        end
      end
      else
       begin
        if (wrEn)
         begin
          tagArray[address] <= inData;
        end
      end
    end
    assign outData = tagArray[address];
 endmodule
