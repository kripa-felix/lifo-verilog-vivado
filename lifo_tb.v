`timescale 1ns/1ps
`include "lifo.v"

module LIFO_TB;

  // Inputs
  reg CLK, Rst, RW, EN;
  reg [31:0] DataIn;

  // Outputs
  wire [31:0] DataOut;
  wire Full, Empty;

  // Instantiate LIFO module
  LIFO LIFO_inst (
    .data_out(DataOut),
    .full(Full),
    .empty(Empty),
    .clk(CLK),
    .rst(Rst),
    .rw(RW),
    .en(EN),
    .data_in(DataIn)
  );

  // Clock generation
  always #5 CLK = ~CLK;

  // Testbench logic
  initial begin
    // Initialize inputs
    CLK = 0; Rst = 1; RW = 0; EN = 0; DataIn = 0;

    // Wait for a few clock cycles after reset
    #20;

    // Test Case 1: Enable Test
    // Write data with enable toggling
    DataIn = 50; RW = 1; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Toggle enable during read operation
    RW = 0; EN = 1;
    #5;
    EN = 0;
    #5;
    EN = 1;
    #5;
    RW = 0; EN = 0;

    // Verify output
    if (DataOut === 50)
      $display("Test Case 1: Pass");
    else
      $display("Test Case 1: Fail");

    // Test Case 2: Reset Test
    // Write data into LIFO
    DataIn = 20; RW = 1; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Perform reset
    Rst = 1;
    #10;
    Rst = 0;
    #10;

    // Verify buffer is empty after reset
    if (Empty)
      $display("Test Case 2: Pass");
    else
      $display("Test Case 2: Fail");

    // Test Case 3: Basic Functionality Test
    // Write data into LIFO
    DataIn = 10; RW = 1; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Read data from LIFO
    RW = 0; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Verify output
    if (DataOut === 10)
      $display("Test Case 3: Pass");
    else
      $display("Test Case 3: Fail");

    // Test Case 4: Overflow Test
    // Fill LIFO buffer
    integer i = 0;
    repeat (16) begin
      DataIn = i; RW = 1; EN = 1;
      #10;
      i = i + 1;
    end

    // Try to write one more entry
    RW = 1; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Verify full flag
    if (Full)
      $display("Test Case 4: Pass");
    else
      $display("Test Case 4: Fail");

    // Test Case 5: Underflow Test
    // Empty LIFO buffer
    repeat (16) begin
      RW = 0; EN = 1;
      #10;
    end

    // Try to read from empty buffer
    RW = 0; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Verify empty flag
    if (Empty)
      $display("Test Case 5: Pass");
    else
      $display("Test Case5: Fail");

    // Test Case 6: Concurrent Read/Write Test
    // Write and read simultaneously
    DataIn = 30; RW = 1; EN = 1;
    #10;
    RW = 0; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Verify output
    if (DataOut === 30)
      $display("Test Case 6: Pass");
    else
      $display("Test Case 6: Fail");

    // Test Case 7: Boundary Test
    // Write data until buffer is almost full
    integer j = 0;
    repeat (15) begin
      DataIn = j; RW = 1; EN = 1;
      #10;
      j = j + 1;
    end

    // Read and write near buffer boundaries
    DataIn = 15; RW = 1; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Verify output
    if (DataOut === 15)
      $display("Test Case 7: Pass");
    else
      $display("Test Case 7: Fail");

    // Test Case 8: Stress Test
    // Stress test with continuous read/write
    integer k = 0;
    repeat (100) begin
      DataIn = k; RW = 1; EN = 1;
      #10;
      RW = 0; EN = 1;
      #10;
      k = k + 1;
    end

    RW = 0; EN = 0;

    // Verify output
    if (DataOut === 99)
      $display("Test Case 8: Pass");
    else
      $display("Test Case 8: Fail");

    // Test Case 9: Performance Test
    // Measure write operation time
    DataIn = 40;
    RW = 1; EN = 1;
    #10;
    RW = 0; EN = 0;

    // Measure read operation time
    RW = 0; EN = 1;
    #10; 
    RW = 0; EN = 0; 

    // Verify output
    if (DataOut === 40)
      $display("Test Case 9: Pass");
    else
      $display("Test Case 9: Fail");

    // Finish simulation
    $finish;
  end

endmodule