`timescale 1ns / 1ps

module alu_tb;

logic [7:0] a_tb;
logic [7:0] b_tb;
logic [2:0] op_tb;
logic [7:0] result_tb;
logic zero_tb;
logic carry_tb;

alu dut
	(
		.a(a_tb),
		.b(b_tb),
		.op(op_tb),
		.result(result_tb),
		.zero(zero_tb),
		.carry(carry_tb)
	);

initial
begin
	a_tb = 8'd10; b_tb = 8'd25; op_tb = 3'b000;
	#10;
	a_tb = 8'd200; b_tb = 8'd100; op_tb = 3'b000;
	#10;
	a_tb = 8'd50; b_tb = 8'd30; op_tb = 3'b001;
	#10;
	a_tb = 8'd10; b_tb = 8'd20; op_tb = 3'b001;
	#10;
	a_tb = 8'hAA; b_tb = 8'h0F; op_tb = 3'b010;
	#10;
	a_tb = 8'hAA; b_tb = 8'h55; op_tb = 3'b011;
	#10;
	a_tb = 8'hFF; b_tb = 8'hFF; op_tb = 3'b100;
	#10;
	a_tb = 8'h0F; b_tb = 8'h00; op_tb = 3'b101;
	#10;
	a_tb = 8'b00000001; b_tb = 8'b0; op_tb = 3'b110;
	#10;
	a_tb = 8'b10000000; b_tb = 8'b0; op_tb = 3'b111;
	#10;
	$finish;
end

endmodule
