// ALU pe 8 biti - 8 operatii selectate pe 3 biti
// circuit pur combinational, dupa stilul de la lab 3 si 5

module alu
	(
		input logic [7:0] a,
		input logic [7:0] b,
		input logic [2:0] op,
		output logic [7:0] result,
		output logic zero,
		output logic carry
	);

logic [8:0] add_extended;
logic [8:0] sub_extended;

always_comb
begin
	add_extended = {1'b0, a} + {1'b0, b};
	sub_extended = {1'b0, a} - {1'b0, b};

	carry = 1'b0;

	case(op)
		3'b000:
			begin
			result = add_extended[7:0];
			carry = add_extended[8];
			end
		3'b001:
			begin
			result = sub_extended[7:0];
			carry = sub_extended[8];
			end
		3'b010:
			begin
			result = a & b;
			end
		3'b011:
			begin
			result = a | b;
			end
		3'b100:
			begin
			result = a ^ b;
			end
		3'b101:
			begin
			result = ~a;
			end
		3'b110:
			begin
			result = a << 1;
			end
		3'b111:
			begin
			result = a >> 1;
			end
		default:
			begin
			result = 8'b0;
			end
	endcase
end

assign zero = (result == 8'b0);

endmodule
