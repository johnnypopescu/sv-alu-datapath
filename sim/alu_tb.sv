// testbench pt ALU - verifica toate operatiile cu valori cunoscute
// contorizeaza testele si raporteaza PASS / FAIL la final

`timescale 1ns / 1ps

module alu_tb;

    logic [7:0] a, b;
    logic [2:0] op;
    logic [7:0] result;
    logic       zero, negative, carry;

    alu dut (
        .a(a), .b(b), .op(op),
        .result(result),
        .zero(zero), .negative(negative), .carry(carry)
    );

    int passed = 0;
    int failed = 0;

    task automatic check(
        input string         name,
        input logic [7:0]    expected_result,
        input logic          expected_zero    = 1'b0,
        input logic          expected_carry   = 1'b0,
        input bit            check_carry      = 1'b0
    );
        #5;
        bit ok;
        ok = (result == expected_result);
        if (check_carry) ok = ok && (carry == expected_carry);

        if (ok) begin
            passed++;
            $display("  PASS  | %-15s | a=%3d b=%3d op=%b -> r=%3d Z=%b N=%b C=%b",
                     name, a, b, op, result, zero, negative, carry);
        end else begin
            failed++;
            $display("  FAIL  | %-15s | a=%3d b=%3d op=%b -> r=%3d (asteptat %0d)",
                     name, a, b, op, result, expected_result);
        end
    endtask

    initial begin
        $display("==========================================");
        $display("    ALU Testbench - 8-bit operations");
        $display("==========================================");
        $display("");
        $display("Result | Test            | Inputs and outputs");
        $display("-------+-----------------+--------------------------------");

        // ADD
        a = 8'd10;  b = 8'd25;  op = 3'b000;  check("ADD basic", 8'd35);
        a = 8'd200; b = 8'd100; op = 3'b000;  check("ADD overflow", 8'd44, 1'b0, 1'b1, 1'b1);
        a = 8'd0;   b = 8'd0;   op = 3'b000;  check("ADD zero", 8'd0);

        // SUB
        a = 8'd50;  b = 8'd30;  op = 3'b001;  check("SUB basic", 8'd20);
        a = 8'd10;  b = 8'd20;  op = 3'b001;  check("SUB borrow", 8'd246);
        a = 8'd100; b = 8'd100; op = 3'b001;  check("SUB equal", 8'd0);

        // AND
        a = 8'hAA; b = 8'h0F; op = 3'b010;  check("AND mask low",  8'h0A);
        a = 8'hFF; b = 8'hF0; op = 3'b010;  check("AND mask high", 8'hF0);
        a = 8'hFF; b = 8'h00; op = 3'b010;  check("AND zero",      8'h00);

        // OR
        a = 8'hAA; b = 8'h55; op = 3'b011;  check("OR complement", 8'hFF);
        a = 8'h0F; b = 8'hF0; op = 3'b011;  check("OR halves",     8'hFF);

        // XOR
        a = 8'hFF; b = 8'hFF; op = 3'b100;  check("XOR same",      8'h00);
        a = 8'hAA; b = 8'h55; op = 3'b100;  check("XOR alternate", 8'hFF);

        // NOT
        a = 8'h0F; op = 3'b101;  check("NOT 0x0F", 8'hF0);
        a = 8'hFF; op = 3'b101;  check("NOT 0xFF", 8'h00);

        // shifts
        a = 8'b0000_0001; op = 3'b110;  check("SHL by 1",     8'b0000_0010);
        a = 8'b0100_0000; op = 3'b110;  check("SHL into MSB", 8'b1000_0000);
        a = 8'b1000_0000; op = 3'b111;  check("SHR from MSB", 8'b0100_0000);
        a = 8'b0000_0001; op = 3'b111;  check("SHR to zero",  8'b0000_0000);

        // sumar final
        $display("");
        $display("==========================================");
        $display("    Rezultat: %0d PASS / %0d FAIL / %0d total",
                 passed, failed, passed + failed);
        $display("==========================================");

        if (failed == 0)
            $display("    Toate testele au trecut.");
        else
            $display("    ATENTIE: %0d teste au esuat!", failed);

        $finish;
    end

endmodule
