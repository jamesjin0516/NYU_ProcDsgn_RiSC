module instruction_memory (
    input [15:0] pc,
    output [15:0] instr
);

    reg [15:0] mem [0:255];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 16'b0;
        end
    end

    assign instr = mem[pc];

endmodule