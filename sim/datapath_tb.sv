// testbench pt datapath-ul intreg
// scenariu: citeste 2 operand-uri din ROM, le aduna, stocheaza in registru

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

    // clock 10ns (100 MHz)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        rom_addr_a = 0;
        rom_addr_b = 0;
        op = 0;
        we_reg = 0;
        reg_addr = 0;

        #20 rst = 0;

        $display("=== DATAPATH TEST ===");

        // Test 1: ADD ROM[0] + ROM[1] = 10 + 25 = 35
        rom_addr_a = 4'd0;
        rom_addr_b = 4'd1;
        op = 3'b000;
        reg_addr = 3'd0;
        we_reg = 1'b1;
        #10;
        $display("[ADD ROM[0]+ROM[1]] result=%0d (asteptat 35)", result);
        we_reg = 1'b0;

        // Test 2: AND ROM[4] & ROM[5] = 0xAA & 0x55 = 0x00
        rom_addr_a = 4'd4;
        rom_addr_b = 4'd5;
        op = 3'b010;
        reg_addr = 3'd1;
        we_reg = 1'b1;
        #10;
        $display("[AND ROM[4]&ROM[5]] result=0x%h (asteptat 0x00, Z=%b)", result, zero);
        we_reg = 1'b0;

        // Test 3: XOR ROM[6] ^ ROM[6] = 0xFF ^ 0xFF = 0
        rom_addr_a = 4'd6;
        rom_addr_b = 4'd6;
        op = 3'b100;
        #10;
        $display("[XOR ROM[6]^ROM[6]] result=%0d Z=%b (asteptat 0, 1)", result, zero);

        // Test 4: SUB ROM[3] - ROM[2] = 200 - 100 = 100
        rom_addr_a = 4'd3;
        rom_addr_b = 4'd2;
        op = 3'b001;
        #10;
        $display("[SUB ROM[3]-ROM[2]] result=%0d (asteptat 100)", result);

        $display("=== DONE ===");
        #20 $finish;
    end

endmodule
