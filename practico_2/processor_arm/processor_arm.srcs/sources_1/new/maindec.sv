`timescale 1ns / 1ps

module maindec (
    input  logic [10:0] Op,
    output logic        Reg2Loc,
    output logic        ALUSrc,
    output logic        MemtoReg,
    output logic        RegWrite,
    output logic        MemRead,
    output logic        MemWrite,
    output logic        Branch,
    output logic [1:0]  ALUOp
);

    always_comb begin
        Reg2Loc  = 0;
        ALUSrc   = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead  = 0;
        MemWrite = 0;
        Branch   = 0;
        ALUOp    = 2'b00;

        casez (Op)
            11'b11111000010: begin // LDUR
                Reg2Loc =  0;
                ALUSrc =   1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead =  1;
                MemWrite = 0;
                Branch =   0;
                ALUOp =    2'b00;
            end
            11'b11111000000: begin // STUR
                Reg2Loc =  1;
                ALUSrc =   1;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead =  0;
                MemWrite = 1;
                Branch =   0;
                ALUOp =    2'b00;
            end
            11'b10110100???: begin // CBZ
                Reg2Loc =  1;
                ALUSrc =   0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead =  0;
                MemWrite = 0;
                Branch =   1;
                ALUOp =    2'b01;
            end
            11'b10001011000,        // ADD
            11'b11001011000,        // SUB
            11'b10001010000,        // AND
            11'b10101010000: begin  // ORR
                Reg2Loc =  0;
                ALUSrc =   0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead =  0;
                MemWrite = 0;
                Branch =   0;
                ALUOp =    2'b10;
            end
            default:
                $display("Tiempo %0t -> Unknown Opcode: %4b", $time, Op);
        endcase
    end
endmodule
