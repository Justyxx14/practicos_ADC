`timescale 1ns / 1ps

module maindec_tb;

    logic [10:0] Op;
    logic Reg2Loc;
    logic ALUSrc;
    logic MemtoReg;
    logic RegWrite;
    logic MemRead;
    logic MemWrite;
    logic Branch;
    logic [1:0] ALUOp;

    maindec dut (.Op(Op), .Reg2Loc(Reg2Loc), .ALUSrc(ALUSrc),
                 .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead),
                 .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));
    
    initial begin
        Op = 11'b11111000010;
        #1;
        if(Reg2Loc != 0 || ALUSrc != 1 || MemtoReg != 1 ||
           RegWrite != 1 || MemRead != 1 || MemWrite != 0 ||
           Branch != 0 || ALUOp != 2'b00)
            $error("LDUR incorrect");
        else
            $display("LDUR correct");
        #10;
        
        Op = 11'b11111000000;
        #1;
        if(Reg2Loc != 1 || ALUSrc != 1 || MemtoReg != 0 ||
           RegWrite != 0 || MemRead != 0 || MemWrite != 1 ||
           Branch != 0 || ALUOp != 2'b00)
            $error("STUR incorrect");
        else
            $display("STUR correct");
        #10;
        
        Op = 11'b10110100???;
        #1;
        if(Reg2Loc != 1 || ALUSrc != 0 || MemtoReg != 0 ||
           RegWrite != 0 || MemRead != 0 || MemWrite != 0 ||
           Branch != 1 || ALUOp != 2'b01)
            $error("CBZ incorrect");
        else
            $display("CBZ correct");
        #10;
        
        Op = 11'b10001011000;
        #1;
        if(Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 ||
           RegWrite != 1 || MemRead != 0 || MemWrite != 0 ||
           Branch != 0 || ALUOp != 2'b10)
            $error("ADD incorrect");
        else
            $display("ADD correct");
        #10;
        
        Op = 11'b11001011000;
        #1;
        if(Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 ||
           RegWrite != 1 || MemRead != 0 || MemWrite != 0 ||
           Branch != 0 || ALUOp != 2'b10)
            $error("SUB incorrect");
        else
            $display("SUB correct");
        #10;
        
        Op = 11'b10001010000;
        #1;
        if(Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 ||
           RegWrite != 1 || MemRead != 0 || MemWrite != 0 ||
           Branch != 0 || ALUOp != 2'b10)
            $error("AND incorrect");
        else
            $display("AND correct");
        #10;
        
        Op = 11'b10101010000;
        #1;
        if(Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 ||
           RegWrite != 1 || MemRead != 0 || MemWrite != 0 ||
           Branch != 0 || ALUOp != 2'b10)
            $error("ORR incorrect");
        else
            $display("ORR correct");
        #10;
        
        Op = 11'b11111111111;
        #1;
        if(Reg2Loc != 0 || ALUSrc != 0 || MemtoReg != 0 ||
           RegWrite != 0 || MemRead != 0 || MemWrite != 0 ||
           Branch != 0 || ALUOp != 2'b00)
            $error("Other Opcode incorrect");
        else
            $display("Other Opcode correct");
        #10;
        
        $display("TESTBENCH TERMINADO");
        $finish;
    end

endmodule
