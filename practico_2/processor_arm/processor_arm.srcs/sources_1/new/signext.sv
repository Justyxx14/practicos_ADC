`timescale 1ns / 1ps

module signext(
    input  logic[31:0] a, 
    output logic[63:0] y
);
    
    always_comb begin 
        if (a[31:21] == 11'b111_1100_0010 ||
            a[31:21] == 11'b111_1100_0000)
            y = {{55{a[20]}}, a[20:12]};

        else if(a[31:24] == 8'b101_1010_0)
            y = {{45{a[23]}}, a[23:5]};
            
        else 
            y = 64'h0;
    end
    
endmodule