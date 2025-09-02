`timescale 1ns / 1ps

module flopr #(parameter N)(
    input logic clk,
    input logic reset,
    input logic [N-1:0] d,
    output logic [N-1:0] q
    );
    
    always_ff @(posedge clk or negedge reset) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
    
endmodule
