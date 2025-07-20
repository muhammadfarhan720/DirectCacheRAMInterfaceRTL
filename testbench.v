// Testbench for design verification

module TB();
	reg globalclock = 0,reset = 0, start = 0;
	reg[14:0] address = 15'b0;
	wire done;
	
	wire[31:0] outData_cache;
    wire[127:0] memOut;
	Cachememorycalldirectmap CMCD(.globalclock(globalclock),.reset(reset),.start(start),.done(done), .address(address), .outData_cache(outData_cache), .memOut(memOut));
	    initial begin
   		#20reset=1;
        #20reset=0;
   		#20 start=1;
   		#20 globalclock=1;
   		#20 globalclock=0;
  		#20 start=0;
   
    			globalclock=~globalclock; 
    			address = 30771 ; // Decimal format of Hexadecimal value of 7833
			#20 globalclock=~globalclock;
			#20 globalclock=~globalclock;
			#20 globalclock=~globalclock;
			#20 globalclock=~globalclock;
			#20 globalclock=~globalclock;
			#20 globalclock=~globalclock;
			#20 globalclock=~globalclock;
			#20 globalclock=~globalclock;
		end

endmodule 
