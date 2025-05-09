module ALU (
    input [15:0] alu_src1,
    input [15:0] alu_src2,
    input ADD,
    input NAND,
    input PASS1,
    input EQ,
    output [15:0] alu_out,
    output eq_out
);

    assign eq_out = alu_src1 == alu_src2;

    always @(*) begin
        if (ADD)
            alu_out = alu_src1 + alu_src2;
        else if (NAND)
            alu_out = ~(alu_src1 & alu_src2);
        else if (PASS1)
            alu_out = alu_src1;
        else
            alu_out = 16'b0;
    end

endmodule