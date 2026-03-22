// register file - 8 registri x 8 biti
// 2 porturi de citire (a, b), 1 port de scriere
// scriere sincrona, citire combinationala

module register_file (
    input  logic        clk,
    input  logic        we,           // write enable
    input  logic [2:0]  addr_write,
    input  logic [2:0]  addr_read_a,
    input  logic [2:0]  addr_read_b,
    input  logic [7:0]  data_in,
    output logic [7:0]  data_out_a,
    output logic [7:0]  data_out_b
);

    logic [7:0] regs [0:7];

    // scriere pe front pozitiv
    always_ff @(posedge clk) begin
        if (we) begin
            regs[addr_write] <= data_in;
        end
    end

    // citire combinationala
    assign data_out_a = regs[addr_read_a];
    assign data_out_b = regs[addr_read_b];

    // init la 0 (functioneaza pe FPGA, nu doar in simulare)
    initial begin
        for (int i = 0; i < 8; i++) regs[i] = 8'b0;
    end

endmodule
