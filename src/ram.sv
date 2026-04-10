module ram(
    input logic clock,
    input logic [2:0] addr_read,
    output logic [7:0] data_read,
    input logic we,
    input logic [2:0] addr_write,
    input logic [7:0] data_write
    );

logic [7:0] memorie_efectiva [0:7];

assign data_read = memorie_efectiva[addr_read];

always_ff @(posedge clock) begin
    if(we == 1) begin
        memorie_efectiva[addr_write] <= data_write;
        end
end

endmodule
