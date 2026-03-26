// testbench pt ALU
// verifica toate cele 8 operatii cu valori cunoscute

`timescale 1ns / 1ps

module alu_tb;

    logic [7:0] a, b;
    logic [2:0] op;
    logic [7:0] result;
    logic       zero, negative, carry;

    // DUT (device under test)
    alu dut (
        .a(a), .b(b), .op(op),
        .result(result),
        .zero(zero), .negative(negative), .carry(carry)
    );

    // task helper pt afisare
    task automatic check(string name, logic [7:0] expected);
        #5;
        $display("[%s] a=%0d b=%0d op=%b -> result=%0d (Z=%b N=%b C=%b) %s",
                 name, a, b, op, result, zero, negative, carry,
                 (result == expected) ? "OK" : "FAIL");
    endtask

    initial begin
        $display("=== ALU TEST ===");

        // ADD
        a = 10; b = 25; op = 3'b000;
        check("ADD", 35);

        // ADD cu carry
        a = 200; b = 100; op = 3'b000;
        check("ADD carry", 44);  // 300 mod 256

        // SUB
        a = 50; b = 30; op = 3'b001;
        check("SUB", 20);

        // SUB cu borrow
        a = 10; b = 20; op = 3'b001;
        check("SUB borrow", 246);  // -10 in complement fata de 2

        // AND
        a = 8'hAA; b = 8'h0F; op = 3'b010;
        check("AND", 8'h0A);

        // OR
        a = 8'hAA; b = 8'h55; op = 3'b011;
        check("OR", 8'hFF);

        // XOR
        a = 8'hFF; b = 8'hFF; op = 3'b100;
        check("XOR zero", 8'h00);  // ar trebui sa fie zero=1

        // NOT
        a = 8'h0F; op = 3'b101;
        check("NOT", 8'hF0);

        // shift stanga
        a = 8'b0000_0001; op = 3'b110;
        check("SHL", 8'b0000_0010);

        // shift dreapta
        a = 8'b1000_0000; op = 3'b111;
        check("SHR", 8'b0100_0000);

        $display("=== DONE ===");
        $finish;
    end

endmodule
