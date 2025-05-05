module program_counter (
    input clk,
    input rst,                // reset
    input [15:0] nextpc,
    output [15:0] pc
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 16'b0; // Reset PC to 0
        end else begin
            pc <= nextpc; // Update PC to next value
        end
    end

endmodule