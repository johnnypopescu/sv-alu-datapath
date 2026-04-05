// testbench datapath - secventa de operatii
// citeste din ROM, ruleaza prin ALU, scrie in RAM

`timescale 1ns / 1ps

module datapath_tb;

logic clock;
logic reset;
logic [2:0] rom_addr_a;
logic [2:0] rom_addr_b;
logic [2:0] op;
logic we_ram;
logic [2:0] ram_addr;
logic [7:0] result;
logic zero;
logic carry;

datapath dut
	(
		.clock(clock),
		.reset(reset),
		.rom_addr_a(rom_addr_a),
		.rom_addr_b(rom_addr_b),
		.op(op),
		.we_ram(we_ram),
		.ram_addr(ram_addr),
		.result(result),
		.zero(zero),
		.carry(carry)
	);

// generare ceas 10ns
always #5 clock = ~clock;

initial
begin
	clock = 0;
	reset = 1;
	rom_addr_a = 0;
	rom_addr_b = 0;
	op = 0;
	we_ram = 0;
	ram_addr = 0;

	#20 reset = 0;

	$display("--- Test Datapath ---");

	// ADD ROM[0] + ROM[1] = 10 + 25
	rom_addr_a = 3'd0;
	rom_addr_b = 3'd1;
	op = 3'b000;
	ram_addr = 3'd0;
	we_ram = 1;
	#10 we_ram = 0;
	$display("ADD ROM[0]+ROM[1]: result=%0d", result);

	// SUB ROM[3] - ROM[2] = 200 - 100
	rom_addr_a = 3'd3;
	rom_addr_b = 3'd2;
	op = 3'b001;
	ram_addr = 3'd1;
	we_ram = 1;
	#10 we_ram = 0;
	$display("SUB ROM[3]-ROM[2]: result=%0d", result);

	// AND ROM[4] & ROM[7] = 0xAA & 0x0F
	rom_addr_a = 3'd4;
	rom_addr_b = 3'd7;
	op = 3'b010;
	ram_addr = 3'd2;
	we_ram = 1;
	#10 we_ram = 0;
	$display("AND ROM[4]&ROM[7]: result=%h", result);

	// XOR ROM[6] ^ ROM[6] = 0
	rom_addr_a = 3'd6;
	rom_addr_b = 3'd6;
	op = 3'b100;
	#10 $display("XOR ROM[6]^ROM[6]: result=%0d zero=%b", result, zero);

	$display("--- Done ---");
	#20 $finish;
end

endmodule
