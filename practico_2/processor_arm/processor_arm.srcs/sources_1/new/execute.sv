`timescale 1ns / 1ps

module sl2_E (
    input  logic  [63:0] imm,
    output logic [63:0] res_sl2
);

    assign res_sl2 = imm << 2;      
endmodule

module adder_E (
    input  logic [63:0] a,
    input  logic [63:0] b,
    output logic [63:0] res_adder
);

    assign res_adder = a + b;
endmodule

module mux_E (
    input  logic [63:0] d0, 
    input  logic [63:0] d1,
    input  logic        s,
    output logic [63:0] y
);

    assign y = (s) ? d1 : d0;
endmodule

module alu_E (
    input  logic [63:0] a, 
    input  logic [63:0] b,
    input  logic [3:0]  aluCtrl,
    output logic [63:0] res_alu,
    output logic        zero
);

    always_comb begin
        case (aluCtrl)
            4'b0000: res_alu = a & b;
            4'b0001: res_alu = a | b;
            4'b0010: res_alu = a + b;
            4'b0110: res_alu = a - b;
            4'b0111: res_alu = b;
            default: begin
                res_alu = 64'h0;
                $display("Unknown alu opcode: %b", aluCtrl);
            end
        endcase
        zero = (res_alu == 0);
    end   
endmodule

module execute #(parameter N = 64) (
    input  logic        AluSrc,
    input  logic [3:0]  AluControl,
    input  logic [63:0] PC_E, 
    input  logic [63:0] signImm_E, 
    input  logic [63:0] readData1_E, 
    input  logic [63:0] readData2_E,
    output logic [63:0] PCBranch_E, 
    output logic [63:0] aluResult_E, 
    output logic [63:0] writeData_E,
    output logic        zero_E
);

    logic [63:0] res_mux; 
    logic [63:0] res_sl2;
    
    // LSL 2
    sl2_E shift_left (
        .imm(signImm_E), 
        .res_sl2(res_sl2)
    );
    
    // SUMADOR DEL PC
    adder_E sumador (
        .a(PC_E), 
        .b(res_sl2), 
        .res_adder(PCBranch_E)
    );
    
    // ELECCION DEL MULTIPLEXOR
    mux_E multiplexor (
        .d0(readData2_E), 
        .d1(signImm_E), 
        .s(AluSrc), 
        .y(res_mux)
    );
    
    // OPERACION DE LA ALU
    alu_E alu (
        .a(readData1_E), 
        .b(res_mux), 
        .aluCtrl(AluControl), 
        .res_alu(aluResult_E), 
        .zero(zero_E)
    );

    assign writeData_E = readData2_E;

endmodule
