`timescale 1ns / 1ps

module alu(
    input logic [63:0] a,
    input logic [63:0] b,
    input logic [3:0] ALUControl,
    output logic [63:0] result,
    output logic zero
);

    always_comb begin
        case (ALUControl)
            4'b0000: begin
                result = a & b;
                zero = (result == 0) ? 1 : 0;
            end
            4'b0001: begin
                result = a | b;
                zero = (result == 0) ? 1 : 0;
            end
            4'b0010: begin
                result = a + b;
                zero = (result == 0) ? 1 : 0;
            end
            4'b0110: begin
                result = a - b;
                zero = (result == 0) ? 1 : 0;
            end
            4'b0111: begin
                result = b;
                zero = (result == 0) ? 1 : 0;
            end
            default: begin
                result = 64'h0;
                zero = (result == 0) ? 1 : 0;
                $display("unknown opcode");
            end
        endcase
    end
    
endmodule