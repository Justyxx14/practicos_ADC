`timescale 1ns / 1ps

module signext_tb;
    logic[31:0] a;
    logic[63:0] y;

    signext dut (.a(a), .y(y));

    initial begin
        a = 32'b11111000010100000000000000000000;
        #1
        if (y != {{55{a[20]}}, a[20:12]})
            $error("LDUR: y should be %h, but is %h", {{55{a[20]}}, a[20:12]}, y);
        else
            $display("LDUR correcto");
        #10;
        a = 32'b11111000000010000000000000000000;
        #1
        if (y != {{55{a[20]}}, a[20:12]})
            $error("STUR: y should be %h, but is %h", {{55{a[20]}}, a[20:12]}, y);
        else
            $display("STUR correcto");
        #10;
        a = 32'b10110100100000000000000000100000;
        #1
        if (y != {{45{a[23]}}, a[23:5]})
            $error("CBZ: y should be %h, but is %h", {{45{a[23]}}, a[23:5]}, y);
        else
            $display("CBZ correcto");
        #10;
        a = 32'b0;
        #1
        if (y != 64'h0)
            $error("y should be %h, but is %h", 64'h0, y);
        else
            $display("OTHER OPCODE correcto");
        #10;
        $display("Finish");
        $finish;
    end       

endmodule