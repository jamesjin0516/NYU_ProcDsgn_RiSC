module top_level (
    input clk,
    input reset,

    output [15:0] curr_pc,
    output [15:0] curr_instr,
    output [0:6] curr_controls    // All control signals together
)

    logic [15:0] next_pc;

    logic [2:0] opcode;
    wire we_reg;
    wire ADD;
    wire NAND;
    wire PASS1;
    wire we_mem;
    wire EQ;
    wire BR;

    logic [15:0] alu_src1;
    logic [15:0] alu_src2;
    wire [15:0] alu_out;
    wire eq_out;

    wire [15:0] data_out;

    logic [2:0] op_src1;
    logic [2:0] op_src2;
    logic [2:0] op_tgt;
    logic [15:0] reg_tgt;
    wire [15:0] reg_src1;
    wire [15:0] reg_src2;

    program_counter PC (
        .clk(clk),
        .rst(reset),
        .nextpc(next_pc)
        .pc(curr_pc)
    );

    instruction_memory IM (
        .pc(curr_pc),
        .instr(curr_instr)
    )

    control_unit CU (
        .opcode(opcode),
        .eq_out(eq_out),
        .we_reg(we_reg),
        .ADD(ADD),
        .NAND(NAND),
        .PASS1(PASS1),
        .we_mem(we_mem),
        .EQ(EQ),
        .BR(BR)
    )

    data_memory DM (
        .clk(clk),
        .we_mem(we_mem),
        .addr(alu_out),
        .data_in(reg_src2),
        .data_out(data_out)
    )

    ALU alu (
        .alu_src1(alu_src1),
        .alu_src2(alu_src2),
        .ADD(ADD),
        .NAND(NAND),
        .PASS1(PASS1),
        .EQ(EQ),
        .alu_out(alu_out),
        .eq_out(eq_out)
    )

    register_file RF (
        .clk(clk),
        .we_reg(we_reg),
        .src1(op_src1),
        .src2(op_src2),
        .tgt(op_tgt),
        .write_data(reg_tgt),
        .src1_val(reg_src1),
        .src2_val(reg_src2)
    )

endmodule