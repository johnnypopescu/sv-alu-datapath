// testbench ALU - aplica seturi de input-uri si afiseaza output-urile

`timescale 1ns / 1ps

module alu_tb;

logic [7:0] a;
logic [7:0] b;
logic [2:0] op;
logic [7:0] result;
logic zero;
logic carry;

alu dut
	(
		.a(a),
		.b(b),
		.op(op),
		.result(result),
		.zero(zero),
		.carry(carry)
	);

initial
begin
	$display("--- Test ALU ---");

	a = 8'd10; b = 8'd25; op = 3'b000;
	#10 $display("ADD: a=%0d b=%0d -> result=%0d carry=%b", a, b, result, carry);

	a = 8'd200; b = 8'd100; op = 3'b000;
	#10 $display("ADD: a=%0d b=%0d -> result=%0d carry=%b", a, b, result, carry);

	a = 8'd50; b = 8'd30; op = 3'b001;
	#10 $display("SUB: a=%0d b=%0d -> result=%0d", a, b, result);

	a = 8'hAA; b = 8'h0F; op = 3'b010;
	#10 $display("AND: a=%h b=%h -> result=%h", a, b, result);

	a = 8'hAA; b = 8'h55; op = 3'b011;
	#10 $display("OR:  a=%h b=%h -> result=%h", a, b, result);

	a = 8'hFF; b = 8'hFF; op = 3'b100;
	#10 $display("XOR: a=%h b=%h -> result=%h zero=%b", a, b, result, zero);

	a = 8'h0F; op = 3'b101;
	#10 $display("NOT: a=%h -> result=%h", a, result);

	a = 8'b00000001; op = 3'b110;
	#10 $display("SHL: a=%b -> result=%b", a, result);

	a = 8'b10000000; op = 3'b111;
	#10 $display("SHR: a=%b -> result=%b", a, result);

	$display("--- Done ---");
	$finish;
end

endmodule
