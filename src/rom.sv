// ROM 16 x 8 biti - operand-uri preincarcate pt teste
// citire combinationala

module rom (
    input  logic [3:0] addr,
    output logic [7:0] data
);

    logic [7:0] mem [0:15];

    initial begin
        mem[0]  = 8'd10;     // 0x0A
        mem[1]  = 8'd25;     // 0x19
        mem[2]  = 8'd100;    // 0x64
        mem[3]  = 8'd200;    // 0xC8
        mem[4]  = 8'hAA;     // 1010_1010
        mem[5]  = 8'h55;     // 0101_0101
        mem[6]  = 8'hFF;
        mem[7]  = 8'h0F;
        mem[8]  = 8'h01;
        mem[9]  = 8'h80;
        mem[10] = 8'd7;
        mem[11] = 8'd3;
        mem[12] = 8'd128;
        mem[13] = 8'd64;
        mem[14] = 8'd0;
        mem[15] = 8'd255;
    end

    assign data = mem[addr];

endmodule
