// Valid bits of cache lines


module VMemory(
  globalclock, reset, wrEn, address, inValidity, isValid
);
    input globalclock, reset, wrEn, inValidity;
    input[9:0] address;
    output isValid;

    reg[1023:0] validArray;
    
    always @(posedge globalclock, posedge reset) begin
      if (reset) 
      begin
        validArray <= 1024'b0;
      end
      else
       begin
        if (wrEn)
         begin
          validArray[address] <= inValidity;
        end
      end
    end
    assign isValid = validArray[address];
endmodule 
