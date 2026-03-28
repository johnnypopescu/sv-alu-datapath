# SystemVerilog ALU + Datapath

8-bit ALU with a small memory subsystem (ROM, RAM, register file) — a mini-datapath that demonstrates how the core components of a CPU fit together.

Written in **SystemVerilog** and synthesized with **Vivado** for the **Boolean Board / Pynq-Z2** FPGA platforms used in the ETTI UPB Digital Integrated Circuits lab.

## What it does

The datapath reads two operands from a preloaded ROM, runs them through the ALU with a chosen operation, and stores the result in a register file. Status flags (Zero, Negative, Carry) drive LEDs on the dev board.

## Modules

| File | Role |
|---|---|
| `src/alu.sv` | 8-bit ALU — 8 operations, combinational |
| `src/register_file.sv` | 8 registers × 8 bits, synchronous write, dual-port read |
| `src/rom.sv` | 16 × 8-bit ROM with preloaded operands |
| `src/ram.sv` | 16 × 8-bit synchronous RAM |
| `src/datapath.sv` | Top-level module wiring everything together |
| `sim/alu_tb.sv` | Testbench for the ALU alone |
| `sim/datapath_tb.sv` | End-to-end testbench |

## ALU operations

| `op[2:0]` | Operation | Description |
|---|---|---|
| `000` | ADD  | `a + b` with carry-out |
| `001` | SUB  | `a - b` with borrow |
| `010` | AND  | `a & b` |
| `011` | OR   | `a \| b` |
| `100` | XOR  | `a ^ b` |
| `101` | NOT  | `~a` (ignores b) |
| `110` | SHL  | `a << 1` |
| `111` | SHR  | `a >> 1` |

Status flags:
- **Zero** — `result == 0`
- **Negative** — MSB of result (signed interpretation)
- **Carry** — carry-out from ADD or borrow from SUB

## How to use in Vivado

1. Open Vivado → **Create New Project**
2. RTL Project, **don't specify sources at this time**
3. Pick board: Boolean Board (or Pynq-Z2)
4. Once created: **Add Sources** → add all files from `src/`
5. **Add Sources** → Simulation sources → add files from `sim/`
6. Set `datapath` as top module for synthesis
7. Set `alu_tb` or `datapath_tb` as top for simulation
8. **Run Simulation → Run Behavioral Simulation**

## Expected simulation output

```
=== ALU TEST ===
[ADD]        a=10  b=25  op=000 -> result=35  (Z=0 N=0 C=0) OK
[ADD carry]  a=200 b=100 op=000 -> result=44  (Z=0 N=0 C=1) OK
[SUB]        a=50  b=30  op=001 -> result=20  (Z=0 N=0 C=0) OK
[AND]        a=170 b=15  op=010 -> result=10  (Z=0 N=0 C=0) OK
...
=== DONE ===
```

## Mapping to the Boolean Board

For physical deployment:
- Switches → `rom_addr_a`, `rom_addr_b`, `op`
- Buttons → `we_reg`, `rst`
- LEDs → `result[7:0]`, `zero`, `negative`, `carry`

A constraints file (`.xdc`) maps these signals to the actual pins of the FPGA.

## Why this design

This is the same pattern used inside real CPUs — fetch operands from memory, push them through the ALU, store the result. Splitting the work into combinational (ALU) and sequential (registers, RAM) blocks is the foundation of digital design.
