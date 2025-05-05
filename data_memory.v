module data_memory (
    input clk,
    input we_mem,            // Write enable signal
    input [15:0] addr,
    input [15:0] data_in,
    output [15:0] data_out
);

    reg [15:0] mem [0:255];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 16'b0;
        end
    end

    always @(posedge clk) begin
        if (we_mem) begin
            mem[addr] <= data_in;
        end
    end

    assign data_out = mem[addr];

endmodule