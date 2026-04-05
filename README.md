# ALU + Datapath in SystemVerilog

Proiect de laborator extins pentru Circuite Integrate Digitale (ETTI UPB) — o unitate aritmetico-logica pe 8 biti, conectata cu ROM, RAM si register file intr-un mic datapath. Verificata prin simulare in Vivado.

## Module

| Fisier | Rol |
|---|---|
| `src/alu.sv` | ALU 8 biti, 8 operatii (combinational) |
| `src/register_file.sv` | 4 registri pe 8 biti, scriere sincrona |
| `src/rom.sv` | ROM 8x8 cu operand-uri preincarcate |
| `src/ram.sv` | RAM 8x8 sincron pentru stocare rezultate |
| `src/datapath.sv` | Top-level care leaga ROM -> ALU -> RAM |
| `sim/alu_tb.sv` | Testbench pentru ALU |
| `sim/datapath_tb.sv` | Testbench end-to-end |

## Operatii ALU

| `op` | Operatie |
|---|---|
| `000` | ADD |
| `001` | SUB |
| `010` | AND |
| `011` | OR |
| `100` | XOR |
| `101` | NOT |
| `110` | SHL (shift stanga) |
| `111` | SHR (shift dreapta) |

Iesiri:
- `result` — rezultatul pe 8 biti
- `zero` — 1 daca rezultatul e 0
- `carry` — carry-out pentru ADD / borrow pentru SUB

## Cum simulezi in Vivado

Nu e nevoie de placa fizica — Vivado simuleaza totul pe calculator.

1. Vivado → **Create New Project** → RTL Project, fara surse
2. **Add Sources** → adauga fisierele din `src/`
3. **Add Sources** → Simulation sources → adauga fisierele din `sim/`
4. Set `alu_tb` ca top pentru simulare
5. **Run Simulation → Run Behavioral Simulation**

## Output asteptat

```
--- Test ALU ---
ADD: a=10 b=25 -> result=35 carry=0
ADD: a=200 b=100 -> result=44 carry=1
SUB: a=50 b=30 -> result=20
AND: a=aa b=0f -> result=0a
OR:  a=aa b=55 -> result=ff
XOR: a=ff b=ff -> result=00 zero=1
NOT: a=0f -> result=f0
SHL: a=00000001 -> result=00000010
SHR: a=10000000 -> result=01000000
--- Done ---
```
