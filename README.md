# lifo-verilog-vivado
Verilog LIFO stack design with testbench, verified and synthesized in Xilinx Vivado

# LIFO (Last-In-First-Out) Stack — Verilog Design

A 32-bit wide, 32-deep LIFO (stack) memory implemented in Verilog HDL, verified with a self-checking testbench, and synthesized/analyzed in Xilinx Vivado (ISE flow).

## Overview

LIFO (Last-In, First-Out) is a stack-based memory access pattern — the most recently written data is the first to be read out, like a stack of plates. This project implements a synchronous LIFO with:

- 32 x 32-bit internal memory array
- Synchronous write (push) and read (pop) control via `rw` and `en`
- `full` / `empty` status flags
- Active-high synchronous reset

## Files

| File | Description |
|---|---|
| `lifo.v` | LIFO stack design (RTL) |
| `lifo_tb.v` | Self-checking testbench — pushes 31 values, then pops and checks each one against the expected LIFO order |

## Port Description

| Port | Direction | Width | Description |
|---|---|---|---|
| `clk` | input | 1 | Clock |
| `rst` | input | 1 | Synchronous, active-high reset |
| `en` | input | 1 | Enable — must be high for read/write to occur |
| `rw` | input | 1 | `1` = write (push), `0` = read (pop) |
| `data_in` | input | 32 | Data to push onto the stack |
| `data_out` | output | 32 | Data popped from the stack |
| `full` | output | 1 | High when the stack has 32 elements |
| `empty` | output | 1 | High when the stack has 0 elements |

## Testbench Summary

The testbench:
1. Resets the design
2. Pushes the values 1 through 31 into the stack
3. Switches to read mode and pops all 31 values
4. Checks each popped value against the expected LIFO order (31, 30, 29, ... 1)
5. Confirms the `empty` flag asserts once the stack is drained

All 31 data checks + the final `empty` check passed in simulation.

## How to Simulate

**Using Icarus Verilog:**
```bash
iverilog -o lifo_tb.vvp lifo.v lifo_tb.v
vvp lifo_tb.vvp
```
This prints `PASS`/`FAIL` for each of the 31 popped values plus the empty-flag check, and also generates a `dump.vcd` waveform file (viewable in GTKWave).

**Using Xilinx Vivado/ISE:**
1. Add `lifo.v` as a design source and `lifo_tb.v` as a simulation source
2. Run Behavioral Simulation to view waveforms
3. Run Synthesis and Implementation to generate timing, utilization, and power reports

## Vivado Results

Design was synthesized and implemented in Vivado. Reports below:

**Output Waveform (simulation console)**
![Output Waveform](screenshots/1_output_waveform.png)

**ISim Simulation Waveform**
![ISim Simulation](screenshots/2_isim_simulation.png)

**Timing Report**
![Timing Report](screenshots/3_timing_report.png)

**Utilization Report**
![Utilization Report](screenshots/4_utilization_report.png)

**Power Report**
![Power Report](screenshots/5_power_report.png)

## Results

- Successfully designed and verified a 32x32 LIFO stack in Verilog
- All simulation checks passed (31/31 data values + empty flag)
- Synthesized in Vivado with reports generated for timing, area (utilization), and power

## Background

This project was completed as part of a Hardware Design / Digital Design lab exercise.
