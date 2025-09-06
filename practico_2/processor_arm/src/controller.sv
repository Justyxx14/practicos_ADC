`timescale 1ns / 1ps

// CONTROLLER

module controller (
	input  logic [10:0] instr,
	output logic [3:0]  AluControl,						
	output logic        reg2loc, 
	output logic        regWrite, 
	output logic        AluSrc, 
	output logic        Branch,
	output logic        memtoReg, 
	output logic        memRead, 
	output logic        memWrite
);
											
	logic [1:0] AluOp_s;
											
	maindec decPpal (
		.Op       (instr), 
		.Reg2Loc  (reg2loc), 
		.ALUSrc   (AluSrc), 
		.MemtoReg (memtoReg), 
		.RegWrite (regWrite), 
		.MemRead  (memRead), 
		.MemWrite (memWrite), 
		.Branch   (Branch), 
		.ALUOp    (AluOp_s)
	);	
					
								
	aludec decAlu (
		.funct      (instr), 
		.aluop      (AluOp_s), 
		.alucontrol (AluControl)
	);		
endmodule
