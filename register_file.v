module register_file (
    input clk,
    input we_reg,          // Write enable signal
    input [2:0] src1,
    input [2:0] src2,
    input [2:0] tgt,
    input [15:0] write_data,
    output [15:0] src1_val,
    output [15:0] src2_val
);

    reg [15:0] registers [0:7];
    
    // Maybe need to debug later
    /*
    wire [15:0] reg0 = registers[0];
    wire [15:0] reg1 = registers[1];
    wire [15:0] reg2 = registers[2];
    wire [15:0] reg3 = registers[3];
    wire [15:0] reg4 = registers[4];
    wire [15:0] reg5 = registers[5];
    wire [15:0] reg6 = registers[6];
    wire [15:0] reg7 = registers[7];
    */

    integer i;
    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            registers[i] = 16'b0;
        end
    end

    assign src1_val = registers[src1];
    assign src2_val = registers[src2];

    always @(posedge clk) begin
        if (we_reg && tgt != 0) begin
            registers[tgt] <= write_data;
        end
    end

endmodule