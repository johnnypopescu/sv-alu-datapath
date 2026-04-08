`timescale 1ns / 1ps

module datapath_tb;

logic clock_tb;
logic reset_tb;
logic [2:0] rom_addr_a_tb;
logic [2:0] rom_addr_b_tb;
logic [2:0] op_tb;
logic we_ram_tb;
logic [2:0] ram_addr_tb;
logic [7:0] result_tb;
logic zero_tb;
logic carry_tb;

datapath dut
	(
		.clock(clock_tb),
		.reset(reset_tb),
		.rom_addr_a(rom_addr_a_tb),
		.rom_addr_b(rom_addr_b_tb),
		.op(op_tb),
		.we_ram(we_ram_tb),
		.ram_addr(ram_addr_tb),
		.result(result_tb),
		.zero(zero_tb),
		.carry(carry_tb)
	);

always #5 clock_tb = ~clock_tb;

initial
begin
	clock_tb = 0;
	reset_tb = 1;
	rom_addr_a_tb = 0;
	rom_addr_b_tb = 0;
	op_tb = 0;
	we_ram_tb = 0;
	ram_addr_tb = 0;

	#20 reset_tb = 0;

	rom_addr_a_tb = 3'd0;
	rom_addr_b_tb = 3'd1;
	op_tb = 3'b000;
	ram_addr_tb = 3'd0;
	we_ram_tb = 1;
	#10 we_ram_tb = 0;

	rom_addr_a_tb = 3'd3;
	rom_addr_b_tb = 3'd2;
	op_tb = 3'b001;
	ram_addr_tb = 3'd1;
	we_ram_tb = 1;
	#10 we_ram_tb = 0;

	rom_addr_a_tb = 3'd4;
	rom_addr_b_tb = 3'd7;
	op_tb = 3'b010;
	ram_addr_tb = 3'd2;
	we_ram_tb = 1;
	#10 we_ram_tb = 0;

	rom_addr_a_tb = 3'd6;
	rom_addr_b_tb = 3'd6;
	op_tb = 3'b100;
	#10;

	#20 $finish;
end

endmodule
