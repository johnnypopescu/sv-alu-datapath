module datapath
	(
		input logic clock,
		input logic reset,
		input logic [2:0] rom_addr_a,
		input logic [2:0] rom_addr_b,
		input logic [2:0] op,
		input logic we_ram,
		input logic [2:0] ram_addr,
		output logic [7:0] result,
		output logic zero,
		output logic carry
	);

logic [7:0] operand_a;
logic [7:0] operand_b;
logic [7:0] alu_result;
logic [7:0] ram_out;

rom rom_a
	(
		.addr(rom_addr_a),
		.data(operand_a)
	);

rom rom_b
	(
		.addr(rom_addr_b),
		.data(operand_b)
	);

alu alu_unit
	(
		.a(operand_a),
		.b(operand_b),
		.op(op),
		.result(alu_result),
		.zero(zero),
		.carry(carry)
	);

ram ram_unit
	(
		.clock(clock),
		.addr_read(ram_addr),
		.data_read(ram_out),
		.we(we_ram),
		.addr_write(ram_addr),
		.data_write(alu_result)
	);

assign result = alu_result;

endmodule
