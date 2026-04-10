`timescale 1ns/1ps

module datapath_TB();

logic clock_t, reset_t;
logic [2:0] rom_addr_a_t, rom_addr_b_t;
logic [2:0] op_t;
logic we_ram_t;
logic [2:0] ram_addr_t;
logic [7:0] result_t;
logic zero_t, carry_t;

initial begin
    clock_t = 0;
    forever #5 clock_t = ~ clock_t;
end

initial begin
       reset_t = 1;
       rom_addr_a_t = 0;
       rom_addr_b_t = 0;
       op_t = 0;
       we_ram_t = 0;
       ram_addr_t = 0;
    #20 reset_t = 0;

    #10 rom_addr_a_t = 3'd0;
        rom_addr_b_t = 3'd1;
        op_t = 3'b000;
        ram_addr_t = 3'd0;
        we_ram_t = 1;
    #10 we_ram_t = 0;

    #10 rom_addr_a_t = 3'd3;
        rom_addr_b_t = 3'd2;
        op_t = 3'b001;
        ram_addr_t = 3'd1;
        we_ram_t = 1;
    #10 we_ram_t = 0;

    #10 rom_addr_a_t = 3'd4;
        rom_addr_b_t = 3'd7;
        op_t = 3'b010;
        ram_addr_t = 3'd2;
        we_ram_t = 1;
    #10 we_ram_t = 0;

    #10 rom_addr_a_t = 3'd6;
        rom_addr_b_t = 3'd6;
        op_t = 3'b100;
        we_ram_t = 0;

    #20 $stop();
end

datapath DUT(
    .clock(clock_t),
    .reset(reset_t),
    .rom_addr_a(rom_addr_a_t),
    .rom_addr_b(rom_addr_b_t),
    .op(op_t),
    .we_ram(we_ram_t),
    .ram_addr(ram_addr_t),
    .result(result_t),
    .zero(zero_t),
    .carry(carry_t)
);

endmodule
