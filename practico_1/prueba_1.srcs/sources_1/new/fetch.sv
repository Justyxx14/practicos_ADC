`timescale 1ns / 1ps

// MODULO MULTIPLEXOR
module mux2_F (
    input logic [63:0] d0, d1,
    input logic s,
    output logic [63:0] y
    );

    assign y = (s) ? d1 : d0;
endmodule

// MODULO FLOPR
module flopr_F (
    input logic clk,
    input logic reset,
    input logic [63:0] d,
    output logic [63:0] q
    );
    
    always_ff @(posedge clk) begin
        if (reset)
            q <= 64'b0;
        else
            q <= d;
    end
endmodule

// MODULO SUMADOR
module adder (
    input logic [63:0] a, b,
    output logic [63:0] y
    );

    assign y = a + b;
endmodule

// MODULO GENERAL FETCH
module fetch(
    input logic PCSrc_F, clk, reset,
    input logic [63:0] PCBranch_F,
    output logic [63:0] imem_addr_F
    );

    logic [63:0] mux_res, flopr_res, adder_res;

    // SELECCION DE PC+4 O BRANCH
    mux2 multiplexor (.d0(adder_res), .d1(PCBranch_F), .s(PCSrc_F), .y(mux_res));

    // SETEO DEL LUGAR DE INSTRUCCION EN LA MEMORIA CON FLOPR
    flopr_2 flopr (.clk(clk), .reset(reset), .d(mux_res), .q(flopr_res));

    // PC+4 CON EL SUMADOR
    adder sumador (.a(flopr_res), .b(64'h4), .y(adder_res));

    // DIRECCIONAR LA MEMORIA A LA INSTRUCCION
    assign imem_addr_F = flopr_res;
endmodule

