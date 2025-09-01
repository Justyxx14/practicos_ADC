`timescale 1ns / 1ps

module flopr(
    input logic clk,
    input logic reset,
    input logic [63:0] d,
    output logic [63:0] q
);
    
    always_ff @(posedge clk or negedge reset) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
    
endmodule
