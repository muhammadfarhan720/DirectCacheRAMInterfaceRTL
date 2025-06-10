// Control unit module

module Control_unit(
  globalclock, reset, start, done, address, wrEn, hit
  
);
    input globalclock, reset, start, hit;
    input[14:0] address;
    output reg done, wrEn;
   
    parameter [1:0] IDLE = 0, START = 1, READ = 2, LOAD = 3;
    reg[1:0] ps, ns;

   always @(ps, start, hit) begin
      case (ps)
        IDLE: ns <= start ? START : IDLE;
        START: ns <= start ? START : READ;
        READ: ns <= hit ? READ : LOAD;
        LOAD: ns <= READ;
        default: ns <= ps;
      endcase
    end

    always @(ps, start, hit) begin
      done <= 0; wrEn <= 0;
      case (ps)
        IDLE: done <= 1;
        LOAD: wrEn <= 1;
        default: begin end
      endcase
    end

    always @(posedge globalclock, posedge reset) begin
      if (reset) begin
        ps <= IDLE;

      end
      else begin
        ps <= ns;
      end
    end

endmodule 