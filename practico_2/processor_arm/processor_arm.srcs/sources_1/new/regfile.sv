`timescale 1ns / 1ps

module regfile(
    input  logic        clk, // clock
    input  logic        we3, // flag de escritura
    input  logic [4:0]  ra1, // posicion de salida a rd1
    input  logic [4:0]  ra2, // posicion de salida a rd2
    input  logic [4:0]  wa3, // posicion de almacenamiento de wd3
    input  logic [63:0] wd3, // entrada de datos
    output logic [63:0] rd1, // salida de datos 1
    output logic [63:0] rd2  // salida de datos 2
);

    logic [63:0] registry [0:31];

    initial begin
        for (int i = 0; i < 31; i++)
            registry[i] = 64'(i);

        registry[31] = 64'h0;
    end

    always_ff @(posedge clk) begin
        if(we3 && wa3 != 5'b11111)
            registry[wa3] <= wd3;
    end

    assign rd1 = (ra1 == 5'b11111) ? 64'h0 : registry[ra1];
    assign rd2 = (ra2 == 5'b11111) ? 64'h0 : registry[ra2];

endmodule
