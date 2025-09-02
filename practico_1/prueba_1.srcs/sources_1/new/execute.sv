`timescale 1ns / 1ps

module sl2_E (
    input logic [63:0] imm,
    output logic [63:0] res_sl2
);
    assign res_sl2 = imm << 2;      
endmodule

module adder_E (
    input logic [63:0] a, b,
    output logic [63:0] res_adder
);
    assign res_adder = a + b;
endmodule

module mux_E (
    input logic [63:0] d0, d1,
    input logic s,
    output logic [63:0] y
    );

    assign y = (s) ? d1 : d0;
endmodule

module alu_E (
    input logic [63:0] a, b,
    input logic [3:0] aluCtrl,
    output logic [63:0] res_alu,
    output logic zero
);

    always_comb begin
        case (aluCtrl)
            4'b0000: begin
                res_alu = a & b;
                zero = (res_alu == 0) ? 1 : 0;
            end
            4'b0001: begin
                res_alu = a | b;
                zero = (res_alu == 0) ? 1 : 0;
            end
            4'b0010: begin
                res_alu = a + b;
                zero = (res_alu == 0) ? 1 : 0;
            end
            4'b0110: begin
                res_alu = a - b;
                zero = (res_alu == 0) ? 1 : 0;
            end
            4'b0111: begin
                res_alu = b;
                zero = (res_alu == 0) ? 1 : 0;
            end
            default: begin
                res_alu = 64'h0;
                zero = (res_alu == 0) ? 1 : 0;
                $display("unknown opcode");
            end
        endcase
    end   
endmodule

module execute(
    input logic ALUSrc,
    input logic [3:0] ALUControl,
    input logic [63:0] PC_E, signImm_E, readData1_E, readData2_E,
    output logic [63:0] PCBranch_E, aluResult_E, writeData_E,
    output logic zero_E
    );

    logic [63:0] res_mux, res_sl2;
    
    // LSL 2
    sl2_E shift_left (.imm(signImm_E), .res_sl2(res_sl2));
    
    // SUMADOR DEL PC
    adder_E sumador (.a(PC_E), .b(res_sl2), .res_adder(PCBranch_E));
    
    // ELECCION DEL MULTIPLEXOR
    mux_E multiplexor (.d0(readData2_E), .d1(signImm_E), 
                       .s(ALUSrc), .y(res_mux));
    
    // OPERACION DE LA ALU
    alu_E alu (.a(readData1_E), .b(res_mux), .aluCtrl(ALUControl), 
               .res_alu(aluResult_E), .zero(zero_E));

    assign writeData_E = readData2_E;

endmodule
