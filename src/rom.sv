module rom
	(
		input logic [2:0] addr,
		output logic [7:0] data
	);

always_comb
begin
	case(addr)
		3'd0: data = 8'd10;
		3'd1: data = 8'd25;
		3'd2: data = 8'd100;
		3'd3: data = 8'd200;
		3'd4: data = 8'hAA;
		3'd5: data = 8'h55;
		3'd6: data = 8'hFF;
		3'd7: data = 8'h0F;
		default: data = 8'b0;
	endcase
end

endmodule
