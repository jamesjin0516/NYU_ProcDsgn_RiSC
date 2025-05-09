module control_unit (
    input [2:0] opcode,
    input eq_out,        // ALU equality check
    
    output we_reg,        // Write enable for register file
    output ADD,
    output NAND,
    output PASS1,
    output we_mem,        // Write enable for data memory
    output EQ,
    output BR             // For selecting program counter + immediate in BEQ
);

    `define ADD_OP = 3'b000;
    `define ADDI_OP = 3'b001;
    `define NAND_OP = 3'b010;
    `define LUI_OP = 3'b011;
    `define SW_OP = 3'b101;
    `define LW_OP = 3'b100;
    `define BEQ_OP = 3'b110;
    `define JALR_OP = 3'b111;

    always @(*) begin
        // reset all control signals
        we_reg = 1'b0;
        ADD = 1'b0;
        NAND = 1'b0;
        PASS1 = 1'b0;
        we_mem = 1'b0;
        EQ = 1'b0;
        BR = 1'b0;
        
        case (opcode)
            ADD_OP: begin
                // Enable ALU add operation and register write
                ADD = 1'b1;
                we_reg = 1'b1;
            end
            
            ADDI_OP: begin
                // Same as ADD
                ADD = 1'b1;
                we_reg = 1'b1;
            end
            
            NAND_OP: begin
                // Enable ALU nand operation and register write
                NAND = 1'b1;
                we_reg = 1'b1;
            end
            
            LUI_OP: begin
                // Pass the left-shifted immediate and enable register write
                PASS1 = 1'b1;
                we_reg = 1'b1;
            end
            
            LW_OP: begin
                // Calculate memory address using ALU add and enable register write
                ADD = 1'b1;
                we_reg = 1'b1;
            end
            
            SW_OP: begin
                // Calculate memory address using ALU add and enable memory write
                ADD = 1'b1;
                we_mem = 1'b1;
            end
            
            BEQ_OP: begin
                // Enable equality check and branch if equal
                EQ = 1'b1;
                BR = eq_out;
            end
            
            JALR_OP: begin
                // Pass SRC1 value to PC and write PC+1 to register
                PASS1 = 1'b1;
                we_reg = 1'b1;
            end
        endcase
    end
    
endmodule