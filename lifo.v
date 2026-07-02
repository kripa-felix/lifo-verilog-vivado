`timescale 1ns/1ps

module LIFO(data_out, full, empty, clk, rst, rw, en, data_in);
 
  input [31:0] data_in;
  input clk, rst, rw, en; 
  
  output [31:0] data_out;
  output full, empty;
  
  reg [31:0] data_out;
  reg [5:0] sp;
  reg [31:0] mem [31:0];
  
  assign full = (sp == 6'b100000) ? 1 : 0;
  assign empty = (sp == 6'b000000) ? 1 : 0;
  
  always @(posedge clk)
  begin
    if (rst)
      begin
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
        mem[sp] <= data_in;
        sp <= sp + 1;
      end
    else if (en & !rw & !empty)
      begin
        sp <= sp - 1;
        data_out <= mem[sp];
      end
  end
endmodule
