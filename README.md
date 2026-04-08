# ALU + Datapath in SystemVerilog

Proiect CID (Circuite Integrate Digitale, ETTI UPB) — ALU pe 8 biti conectata cu ROM, RAM si register file. Simulata in Vivado.

## Module

| Fisier | Rol |
|---|---|
| `src/alu.sv` | ALU 8 biti, 8 operatii (combinational) |
| `src/register_file.sv` | 4 registri pe 8 biti |
| `src/rom.sv` | ROM 8x8 cu operand-uri |
| `src/ram.sv` | RAM 8x8 sincron |
| `src/datapath.sv` | Top-level |
| `sim/alu_tb.sv` | Testbench ALU |
| `sim/datapath_tb.sv` | Testbench datapath |

## Operatii ALU

| `op` | Operatie |
|---|---|
| `000` | ADD |
| `001` | SUB |
| `010` | AND |
| `011` | OR |
| `100` | XOR |
| `101` | NOT |
| `110` | SHL |
| `111` | SHR |

## Simulare in Vivado

1. Create New Project -> RTL Project, fara surse
2. Add Sources -> design sources -> `src/`
3. Add Sources -> simulation sources -> `sim/`
4. Set `alu_tb` ca top de simulare
5. Run Simulation -> Run Behavioral Simulation
6. Verifica semnalele in waveform
