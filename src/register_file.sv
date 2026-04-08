module register_file
	(
		input logic clock,
		input logic reset,
		input logic we,
		input logic [1:0] addr_write,
		input logic [1:0] addr_read,
		input logic [7:0] data_in,
		output logic [7:0] data_out
	);

logic [7:0] regs [0:3];

always_ff @(posedge clock)
begin
	if(reset == 1)
		begin
		regs[0] <= 8'b0;
		regs[1] <= 8'b0;
		regs[2] <= 8'b0;
		regs[3] <= 8'b0;
		end
	else
		begin
		if(we == 1)
			begin
			regs[addr_write] <= data_in;
			end
		end
end

assign data_out = regs[addr_read];

endmodule
