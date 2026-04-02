# 8-bit ALU + Datapath in SystemVerilog

A minimal **8-bit processor datapath** implemented in SystemVerilog: an ALU with 8 operations connected to a register file, ROM (instructions / operands) and RAM (results). Verified through behavioral simulation in Vivado.

This is the core of how a real CPU works — fetch operands from memory, run them through the ALU, write the result back. Built while studying *Digital Integrated Circuits* at ETTI UPB.

## Architecture

```
   +-------+        +-----+        +----------+
   |  ROM  | -----> |     | -----> | Register |
   +-------+        | ALU |        |   File   |
   |  ROM  | -----> |     |        +----------+
   +-------+        +-----+              |
                       |                 |
                    flags                v
                  (Z, N, C)         result LEDs
```

## Modules

| File | Role | Lines |
|---|---|---|
| `src/alu.sv` | 8-bit ALU, 8 operations, combinational | ~50 |
| `src/register_file.sv` | 8 × 8-bit registers, dual-port read, sync write | ~30 |
| `src/rom.sv` | 16 × 8-bit ROM with preloaded operands | ~30 |
| `src/ram.sv` | 16 × 8-bit synchronous RAM | ~20 |
| `src/datapath.sv` | Top-level wiring everything together | ~70 |
| `sim/alu_tb.sv` | Unit testbench for the ALU (20+ test cases) | ~95 |
| `sim/datapath_tb.sv` | End-to-end testbench with PASS/FAIL counters | ~125 |

## ALU operations

| `op[2:0]` | Operation | Description |
|---|---|---|
| `000` | ADD  | `a + b` with carry-out |
| `001` | SUB  | `a - b` with borrow |
| `010` | AND  | `a & b` |
| `011` | OR   | `a \| b` |
| `100` | XOR  | `a ^ b` |
| `101` | NOT  | `~a` |
| `110` | SHL  | `a << 1` |
| `111` | SHR  | `a >> 1` |

Status flags:
- **Zero** — `result == 0`
- **Negative** — MSB of result (signed interpretation)
- **Carry** — carry-out from ADD or borrow from SUB

## How to simulate (no FPGA board needed)

Behavioral simulation runs entirely on your PC — Vivado simulates the digital circuit timing-accurately without any hardware.

1. Open **Vivado** → **Create New Project** → RTL Project, no sources yet
2. **Add Sources** → Design sources → add everything from `src/`
3. **Add Sources** → Simulation sources → add files from `sim/`
4. Set `alu_tb` (or `datapath_tb`) as simulation top
5. **Run Simulation → Run Behavioral Simulation**

The Tcl Console will print test results live.

## Expected simulation output

```
==========================================
    ALU Testbench - 8-bit operations
==========================================

Result | Test            | Inputs and outputs
-------+-----------------+--------------------------------
  PASS  | ADD basic       | a= 10 b= 25 op=000 -> r= 35 Z=0 N=0 C=0
  PASS  | ADD overflow    | a=200 b=100 op=000 -> r= 44 Z=0 N=0 C=1
  PASS  | SUB basic       | a= 50 b= 30 op=001 -> r= 20 Z=0 N=0 C=0
  PASS  | SUB borrow      | a= 10 b= 20 op=001 -> r=246 Z=0 N=1 C=1
  PASS  | AND mask low    | a=170 b= 15 op=010 -> r= 10 Z=0 N=0 C=0
  PASS  | XOR same        | a=255 b=255 op=100 -> r=  0 Z=1 N=0 C=0
  ...

==========================================
    Rezultat: 20 PASS / 0 FAIL / 20 total
==========================================
    Toate testele au trecut.
```

## Optional — deploy to a real FPGA

The project synthesizes cleanly for the Boolean Board or Pynq-Z2:
- Switches → `op[2:0]`, `rom_addr_a`, `rom_addr_b`
- Buttons → `we_reg`, `rst`
- LEDs → `result[7:0]`, `zero`, `negative`, `carry`

Add a constraints file (`.xdc`) mapping these signals to the board's physical pins.

## Why this design matters

Every CPU — from a 8-bit Arduino to a modern x86 — has the same basic shape: registers and memory feed an ALU, the ALU computes, results go back to storage. By building this skeleton in hardware, you learn:

- How synchronous design works (clocked register writes, combinational reads)
- The cost of operations at gate level (ADD needs ripple-carry, shift is just wiring)
- How memory and compute fit together in a real datapath
