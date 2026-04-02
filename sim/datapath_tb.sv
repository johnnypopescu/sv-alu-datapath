// testbench pt datapath-ul intreg
// simuleaza scenarii reale: incarca operand-uri din ROM, ruleaza prin ALU, stocheaza in registri
// contorizeaza PASS / FAIL la final

`timescale 1ns / 1ps

module datapath_tb;

    logic       clk;
    logic       rst;
    logic [3:0] rom_addr_a;
    logic [3:0] rom_addr_b;
    logic [2:0] op;
    logic       we_reg;
    logic [2:0] reg_addr;
    logic [7:0] result;
    logic       zero, negative, carry;

    datapath dut (
        .clk(clk), .rst(rst),
        .rom_addr_a(rom_addr_a),
        .rom_addr_b(rom_addr_b),
        .op(op),
        .we_reg(we_reg),
        .reg_addr(reg_addr),
        .result(result),
        .zero(zero), .negative(negative), .carry(carry)
    );

    // clock 100 MHz (perioada 10 ns)
    always #5 clk = ~clk;

    int passed = 0;
    int failed = 0;

    task automatic run_op(
        input string      name,
        input logic [3:0] addr_a,
        input logic [3:0] addr_b,
        input logic [2:0] operation,
        input logic [2:0] dest_reg,
        input logic [7:0] expected
    );
        rom_addr_a = addr_a;
        rom_addr_b = addr_b;
        op         = operation;
        reg_addr   = dest_reg;
        we_reg     = 1'b1;
        #10;
        we_reg = 1'b0;
        #2;

        if (result == expected) begin
            passed++;
            $display("  PASS  | %-25s | result = %0d", name, result);
        end else begin
            failed++;
            $display("  FAIL  | %-25s | got %0d, expected %0d", name, result, expected);
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        rom_addr_a = 0;
        rom_addr_b = 0;
        op = 0;
        we_reg = 0;
        reg_addr = 0;

        #20 rst = 0;

        $display("=================================================");
        $display("    Datapath Testbench - end-to-end scenarios");
        $display("=================================================");
        $display("");
        $display("    ROM map: addr 0=10, 1=25, 2=100, 3=200,");
        $display("             4=0xAA, 5=0x55, 6=0xFF, 7=0x0F");
        $display("");
        $display("Result | Test                      | Output");
        $display("-------+---------------------------+-----------------");

        // operatii aritmetice
        run_op("ADD 10 + 25",            4'd0, 4'd1, 3'b000, 3'd0, 8'd35);
        run_op("ADD 200 + 100 (carry)",  4'd3, 4'd2, 3'b000, 3'd1, 8'd44);
        run_op("SUB 200 - 100",          4'd3, 4'd2, 3'b001, 3'd2, 8'd100);
        run_op("SUB 10 - 25 (borrow)",   4'd0, 4'd1, 3'b001, 3'd3, 8'd241);

        // operatii logice
        run_op("AND 0xAA & 0x0F",        4'd4, 4'd7, 3'b010, 3'd4, 8'h0A);
        run_op("OR  0xAA | 0x55",        4'd4, 4'd5, 3'b011, 3'd5, 8'hFF);
        run_op("XOR 0xFF ^ 0xFF",        4'd6, 4'd6, 3'b100, 3'd6, 8'h00);
        run_op("NOT 0x0F",               4'd7, 4'd0, 3'b101, 3'd7, 8'hF0);

        // shifts
        run_op("SHL 0x01 << 1",          4'd8, 4'd0, 3'b110, 3'd0, 8'h02);
        run_op("SHR 0x80 >> 1",          4'd9, 4'd0, 3'b111, 3'd1, 8'h40);

        // verificare flag Zero
        rom_addr_a = 4'd14;  // ROM[14] = 0
        rom_addr_b = 4'd14;
        op = 3'b000;
        #10;
        if (zero == 1'b1) begin
            passed++;
            $display("  PASS  | Zero flag (0 + 0)         | Z=1 OK");
        end else begin
            failed++;
            $display("  FAIL  | Zero flag (0 + 0)         | Z=%b expected 1", zero);
        end

        $display("");
        $display("=================================================");
        $display("    Rezultat: %0d PASS / %0d FAIL / %0d total",
                 passed, failed, passed + failed);
        $display("=================================================");

        if (failed == 0)
            $display("    Datapath functioneaza corect end-to-end.");
        else
            $display("    ATENTIE: %0d teste au esuat!", failed);

        #20 $finish;
    end

endmodule
