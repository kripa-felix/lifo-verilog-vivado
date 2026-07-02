`timescale 1ns/1ps

// LIFO (stack) memory - 32 locations, 32 bits wide
// last value pushed in is the first one popped out
// sp = stack pointer, points to the next free slot

module LIFO(data_out, full, empty, clk, rst, rw, en, data_in);
 
  input [31:0] data_in;
  input clk, rst, rw, en;   // rw = 1 -> write/push, rw = 0 -> read/pop
  
  output [31:0] data_out;
  output full, empty;
  
  reg [31:0] data_out;
  reg [5:0] sp;              // 6 bits so it can count up to 32 (need to hit 100000 for full)
  reg [31:0] mem [31:0];     // the actual stack, 32 words
  
  // full when sp has counted all the way up to 32, empty when sp is back to 0
  assign full = (sp == 6'b100000) ? 1 : 0;
  assign empty = (sp == 6'b000000) ? 1 : 0;
  
  always @(posedge clk)
  begin
    if (rst)
      begin
        // clearing every location on reset, sp starts at 1 not 0
        // (index 0 is not used for data, first push goes to mem[1])
        mem[0] <= 0;mem[1] <= 0;mem[2] <= 0;mem[3] <= 0;
        mem[4] <= 0;mem[5] <= 0;mem[6] <= 0;mem[7] <= 0;
        mem[8] <= 0;mem[9] <= 0;mem[10] <= 0;mem[11] <= 0;
        mem[12] <= 0;mem[13] <= 0;mem[14] <= 0;mem[15] <= 0;
        mem[16] <= 0;mem[17] <= 0;mem[18] <= 0;mem[19] <= 0;
        mem[20] <= 0;mem[21] <= 0;mem[22] <= 0;mem[23] <= 0;
        mem[24] <= 0;mem[25] <= 0;mem[26] <= 0;mem[27] <= 0;
        mem[28] <= 0;mem[29] <= 0;mem[30] <= 0;mem[31] <= 0;
        data_out <=0; sp <=1;
      end
    else if (en & rw & !full)
      begin
        // push: write data at current sp, then move sp up
        mem[sp] <= data_in;
        sp <= sp + 1;
      end
    else if (en & !rw & !empty)
      begin
        // pop: move sp down first, then read from that location
        // (this is why last value written is the first one read back)
        sp <= sp - 1;
        data_out <= mem[sp];
      end
  end
endmodule
