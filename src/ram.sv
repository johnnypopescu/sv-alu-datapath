// RAM sincron 16 x 8 biti - pt stocare rezultate
// scriere sincrona, citire combinationala

module ram (
    input  logic       clk,
    input  logic       we,
    input  logic [3:0] addr,
    input  logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] mem [0:15];

    always_ff @(posedge clk) begin
        if (we) mem[addr] <= data_in;
    end

    assign data_out = mem[addr];

    initial begin
        for (int i = 0; i < 16; i++) mem[i] = 8'b0;
    end

endmodule
