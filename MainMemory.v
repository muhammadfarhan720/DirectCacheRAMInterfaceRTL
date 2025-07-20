// RAM module memory arrays

module MainMemory(
  address, outData_mem
);
    input[12:0] address;
    output[127:0] outData_mem;

    reg[31:0] dataArray[32767:0];
    integer i;

    assign outData_mem = {dataArray[{address, 2'b00}], dataArray[{address, 2'b01}],
	dataArray[{address, 2'b10}], dataArray[{address, 2'b11}]};
   
    initial begin
	for(i = 0; i < 32767; i = i + 1) begin
	    dataArray[i] = i; //Saving value inside the memory blocks as same as it's index numbers
	end
    end

endmodule 
