`timescale 1ns / 1ps

module flopr_tb;
    logic clk;
    logic reset;
    logic [63:0] d;
    logic [63:0] q;
    
    flopr #(.N(64)) dut (.clk(clk), .reset(reset), .d(d), .q(q));
    
    // clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // every 10ns
    end
    
    initial begin
        reset = 1;
        for (int i = 0; i < 10; i++) begin
            d = 64'h1 + i; // change number
            @(posedge clk);
            if (i == 4) reset = 0;

            if (i < 5) begin
                if (q != 64'h0) 
                    $error("Cycle %0d: q should be 0, but is %h", i, q);
            end 
            else begin
                if (q != 64'h1 + i) 
                    $error("Cycle %0d: q should be %h, but is %h", i+1, 64'h1 + i, q);
            end
        end
        $display("Test N=64 done");
    end
    
    // 32 bit test
    
    logic [31:0] d32;
    logic [31:0] q32;
    
    flopr #(.N(32)) dut32 (.clk(clk), .reset(reset), .d(d32), .q(q32));
    initial begin
        reset = 1;
        for (int i = 0; i < 10; i++) begin
            d32 = 32'h1 + i; // change number
            @(posedge clk);
            if (i == 4) reset = 0;

            if (i < 5) begin
                if (q32 != 32'h0) 
                    $error("Cycle %0d: q should be 0, but is %h", i+1, q32);
            end else begin
                if (q32 != 32'h1 + i) 
                    $error("Cycle %0d: q should be %h, but is %h", i+1, 32'h1 + i, q32);
            end
        end
        $display("Test N=32 done");
    end
    
endmodule
