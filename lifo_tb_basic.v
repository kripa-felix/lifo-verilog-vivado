`timescale 1ns / 1ps

// basic testbench - straightforward push then pop test
// pushes 1 to 31 into the stack, then pops everything back out
// and checks each value against what LIFO order should give
// (this is the one that produced the PASS/FAIL results in the lab report)

module tb;

  wire [31:0] data_out;
  wire full, empty;
  reg clk, rst, rw, en;
  reg [31:0] data_in;

  LIFO dut(.data_out(data_out), .full(full), .empty(empty), .clk(clk),
            .rst(rst), .rw(rw), .en(en), .data_in(data_in));

  initial
  begin
    // reset first
    en = 1; clk = 0; data_in = 32'd0;
    rst = 1; clk = 1; #5; clk = 0; #5;
    rst = 0;

    // ---- push phase ----
    // push values 1 through 31 one at a time, one clk pulse each
    rw = 1;
    data_in = 32'd1;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd2;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd3;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd4;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd5;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd6;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd7;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd8;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd9;  clk = 1; #5; clk = 0; #5;
    data_in = 32'd10; clk = 1; #5; clk = 0; #5;
    data_in = 32'd11; clk = 1; #5; clk = 0; #5;
    data_in = 32'd12; clk = 1; #5; clk = 0; #5;
    data_in = 32'd13; clk = 1; #5; clk = 0; #5;
    data_in = 32'd14; clk = 1; #5; clk = 0; #5;
    data_in = 32'd15; clk = 1; #5; clk = 0; #5;
    data_in = 32'd16; clk = 1; #5; clk = 0; #5;
    data_in = 32'd17; clk = 1; #5; clk = 0; #5;
    data_in = 32'd18; clk = 1; #5; clk = 0; #5;
    data_in = 32'd19; clk = 1; #5; clk = 0; #5;
    data_in = 32'd20; clk = 1; #5; clk = 0; #5;
    data_in = 32'd21; clk = 1; #5; clk = 0; #5;
    data_in = 32'd22; clk = 1; #5; clk = 0; #5;
    data_in = 32'd23; clk = 1; #5; clk = 0; #5;
    data_in = 32'd24; clk = 1; #5; clk = 0; #5;
    data_in = 32'd25; clk = 1; #5; clk = 0; #5;
    data_in = 32'd26; clk = 1; #5; clk = 0; #5;
    data_in = 32'd27; clk = 1; #5; clk = 0; #5;
    data_in = 32'd28; clk = 1; #5; clk = 0; #5;
    data_in = 32'd29; clk = 1; #5; clk = 0; #5;
    data_in = 32'd30; clk = 1; #5; clk = 0; #5;
    data_in = 32'd31; clk = 1; #5; clk = 0; #5;

    // ---- switch to pop phase ----
    rw = 0; en = 1;

    // giving one extra clk pulse here before the checks start -
    // sp is still one location ahead right after switching to read,
    // so the very first data_out read is not valid yet. this dummy
    // pulse lines it up before the actual checking begins below
    clk = 1; #5; clk = 0; #5;

    // ---- pop phase with checks ----
    // pop everything back out, should come out in reverse: 31, 30, ... 1
    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd31 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd30 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd29 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd28 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd27 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd26 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd25 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd24 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd23 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd22 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd21 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd20 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd19 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd18 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd17 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd16 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd15 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd14 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd13 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd12 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd11 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd10 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd9 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd8 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd7 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd6 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd5 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd4 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd3 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd2 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    clk = 1; #5; clk = 0; #5;
    if ( data_out === 32'd1 )
      $display("PASS %d ", data_out);
    else
      $display("FAIL %d ", data_out);

    // stack should be back to empty now, one last check
    clk = 1; #5; clk = 0; #5;
    if ( empty === 1 )
      $display("PASS %d ", empty);
    else
      $display("FAIL %d ", empty);
  end

  // dump waveform for viewing in gtkwave
  initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars(1, tb);
  end

endmodule
