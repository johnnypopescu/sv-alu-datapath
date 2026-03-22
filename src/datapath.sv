// datapath - modulul top
// leaga ROM -> registers -> ALU -> RAM
// expune butoanele si switch-urile placii Boolean Board

module datapath (
    input  logic       clk,
    input  logic       rst,

    // control de pe placa
    input  logic [3:0] rom_addr_a,   // adresa ROM pt operand a
    input  logic [3:0] rom_addr_b,   // adresa ROM pt operand b
    input  logic [2:0] op,           // selectie operatie ALU
    input  logic       we_reg,       // scrie rezultat in register file
    input  logic [2:0] reg_addr,

    // output pt LED-uri
    output logic [7:0] result,
    output logic       zero,
    output logic       negative,
    output logic       carry
);

    // semnale interne
    logic [7:0] operand_a;
    logic [7:0] operand_b;
    logic [7:0] alu_result;

    // ROM - 2 instante ca sa citim 2 operand-uri simultan
    rom rom_a (
        .addr(rom_addr_a),
        .data(operand_a)
    );

    rom rom_b (
        .addr(rom_addr_b),
        .data(operand_b)
    );

    // ALU
    alu alu_unit (
        .a       (operand_a),
        .b       (operand_b),
        .op      (op),
        .result  (alu_result),
        .zero    (zero),
        .negative(negative),
        .carry   (carry)
    );

    // register file - stocheaza rezultatul pt urmatoarea operatie
    logic [7:0] reg_out_a, reg_out_b;
    register_file regs (
        .clk         (clk),
        .we          (we_reg),
        .addr_write  (reg_addr),
        .addr_read_a (reg_addr),
        .addr_read_b (3'b0),
        .data_in     (alu_result),
        .data_out_a  (reg_out_a),
        .data_out_b  (reg_out_b)
    );

    assign result = alu_result;

endmodule
