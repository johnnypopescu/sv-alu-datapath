`timescale 1ns/1ps

module alu_TB();

logic [7:0] a_t, b_t;
logic [2:0] op_t;
logic [7:0] result_t;
logic zero_t, carry_t;

initial begin
       a_t = 8'd10;  b_t = 8'd25;  op_t = 3'b000;
    #10 a_t = 8'd200; b_t = 8'd100; op_t = 3'b000;
    #10 a_t = 8'd50;  b_t = 8'd30;  op_t = 3'b001;
    #10 a_t = 8'd10;  b_t = 8'd20;  op_t = 3'b001;
    #10 a_t = 8'hAA;  b_t = 8'h0F;  op_t = 3'b010;
    #10 a_t = 8'hAA;  b_t = 8'h55;  op_t = 3'b011;
    #10 a_t = 8'hFF;  b_t = 8'hFF;  op_t = 3'b100;
    #10 a_t = 8'h0F;  b_t = 8'h00;  op_t = 3'b101;
    #10 a_t = 8'b00000001; b_t = 8'b0; op_t = 3'b110;
    #10 a_t = 8'b10000000; b_t = 8'b0; op_t = 3'b111;
    #10 $stop();
end

alu DUT(
    .a(a_t),
    .b(b_t),
    .op(op_t),
    .result(result_t),
    .zero(zero_t),
    .carry(carry_t)
);

endmodule
