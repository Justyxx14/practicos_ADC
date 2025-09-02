`timescale 1ns / 1ps

module alu_tb;
    logic [63:0] a, b;
    logic [3:0] ALUControl;
    logic [63:0] result;
    logic zero;

    alu dut (.a(a), .b(b), .ALUControl(ALUControl), .result(result), .zero(zero));

    task automatic test_alu(
        input logic [63:0] a_in,
        input logic [63:0] b_in,
        input logic [3:0] ALU_in,
        input logic [63:0] result_expected
    );

        begin
            a = a_in;
            b = b_in;
            ALUControl = ALU_in;
            #1;
            
            if(result != result_expected)
                $error("result should be %h, but is %h", result_expected, result);
            else begin
                $display("ALU correct:");
                $display("a = %h, b = %h, op = %h, result_expected = %h -> result = %h", a, b, ALU_in, result_expected, result);
            end
            
            if(result == 0 && zero != 1)
                $error("result = 0, but zero != 1");
        end

    endtask

    initial begin    
        // two positives
        $display("Test 1");
        test_alu(64'h1, 64'h2, 4'b0000, 64'h0); // a & b
        $display("Test 2");
        test_alu(64'h1, 64'h2, 4'b0001, 64'h3); // a | b
        $display("Test 3");
        test_alu(64'h1, 64'h2, 4'b0010, 64'h3); // a + b
        $display("Test 4");
        test_alu(64'h3, 64'h2, 4'b0110, 64'h1); // a - b
        $display("Test 5");
        test_alu(64'h1, 64'h2, 4'b0111, 64'h2); // pass input b
        $display("Test 6");
        test_alu(64'h1, 64'h2, 4'b0011, 64'h0); // other opcode

        // two negatives
        $display("Test 7");
        test_alu(64'h8000000000000001, 64'h8000000000000002, 4'b0000, 64'h8000000000000000);
        $display("Test 8");
        test_alu(64'h8000000000000001, 64'h8000000000000002, 4'b0001, 64'h8000000000000003);
        $display("Test 9");
        test_alu(64'hFFFFFFFFFFFFFFFF, 64'hFFFFFFFFFFFFFFFE, 4'b0010, 64'hFFFFFFFFFFFFFFFD);
        $display("Test 10");
        test_alu(64'hFFFFFFFFFFFFFFFD, 64'hFFFFFFFFFFFFFFFF, 4'b0110, 64'hFFFFFFFFFFFFFFFE);
        $display("Test 11");
        test_alu(64'h8000000000000001, 64'h8000000000000002, 4'b0111, 64'h8000000000000002);
        $display("Test 12");
        test_alu(64'h8000000000000001, 64'h8000000000000002, 4'b0011, 64'h0);

        // one positive and one negative
        $display("Test 13");
        test_alu(64'h1, 64'h8000000000000001, 4'b0000, 64'h0000000000000001);
        $display("Test 14");
        test_alu(64'h1, 64'h8000000000000001, 4'b0001, 64'h8000000000000001);
        $display("Test 15");
        test_alu(64'h2, 64'hFFFFFFFFFFFFFFFF, 4'b0010, 64'h1);
        $display("Test 16");
        test_alu(64'h2, 64'hFFFFFFFFFFFFFFFF, 4'b0110, 64'h3);
        $display("Test 17");
        test_alu(64'h1, 64'h8000000000000001, 4'b0111, 64'h8000000000000001);
        $display("Test 18");
        test_alu(64'h1, 64'h8000000000000001, 4'b0011, 64'h0);
        
        $display("Test OVERFLOW");
        a = 64'h7FFFFFFFFFFFFFFF;
        b = 64'h0000000000000002;
        ALUControl = 4'b0010;

        $display("TEST OVERFLOW -> result = %h, zero = %h", result, zero);
        
        #10;
        $finish;
    end

endmodule