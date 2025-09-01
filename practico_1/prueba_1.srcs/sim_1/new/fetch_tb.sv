`timescale 1ns / 1ps

module fetch_tb;
    logic PCSrc_F, clk, reset;
    logic [63:0] PCBranch_F;
    logic [63:0] imem_addr_F;

    fetch dut (
        .PCSrc_F(PCSrc_F), .clk(clk), .reset(reset),
        .PCBranch_F(PCBranch_F), .imem_addr_F(imem_addr_F)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // every 10ns
    end

    initial begin
        PCSrc_F = 0;
        PCBranch_F = 64'h100;
        reset = 1;

        repeat (5) @(posedge clk);
        reset = 0;

        if(imem_addr_F != 64'h0)
            $error("imem should be 0, but is %h", imem_addr_F);
        else
            $display("Correct imem = %h", imem_addr_F);
        
        repeat (3) @(posedge clk);

        if(imem_addr_F != 64'hC)
            $error("imem should be %h, but is %h", 64'hc, imem_addr_F);
        else
            $display("Correct: expected = %h, imem = %h", 64'hc, imem_addr_F);

        PCSrc_F = 1;
        @(posedge clk);
        #1;
        if(imem_addr_F != 64'h100)
            $error("imem should be %h, but is %h", 64'h100, imem_addr_F);
        else
            $display("Correct: expected = %h, imem = %h", 64'h100, imem_addr_F);
    end

endmodule
