// ALU 8 biti - 8 operatii selectate pe 3 biti
// pur combinational

module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [2:0] op,
    output logic [7:0] result,
    output logic       zero,      // 1 daca rezultatul e 0
    output logic       negative,  // 1 daca MSB = 1 (interpretare cu semn)
    output logic       carry      // carry-out pt ADD/SUB
);

    // semnal intern pe 9 biti ca sa capteze carry-ul
    logic [8:0] add_result;
    logic [8:0] sub_result;

    always_comb begin
        // default - evita latch-uri
        result = 8'b0;
        carry  = 1'b0;

        add_result = {1'b0, a} + {1'b0, b};
        sub_result = {1'b0, a} - {1'b0, b};

        case (op)
            3'b000: begin  // ADD
                result = add_result[7:0];
                carry  = add_result[8];
            end
            3'b001: begin  // SUB
                result = sub_result[7:0];
                carry  = sub_result[8];
            end
            3'b010: result = a & b;       // AND
            3'b011: result = a | b;       // OR
            3'b100: result = a ^ b;       // XOR
            3'b101: result = ~a;          // NOT (ignora b)
            3'b110: result = a << 1;      // shift stanga
            3'b111: result = a >> 1;      // shift dreapta
            default: result = 8'b0;
        endcase
    end

    // flags
    assign zero     = (result == 8'b0);
    assign negative = result[7];

endmodule
