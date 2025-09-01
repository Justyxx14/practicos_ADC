`timescale 1ns / 1ps

module regfile_tb;
    logic clk;        
    logic we3;        
    logic [4:0] ra1; 
    logic [4:0] ra2; 
    logic [4:0] wa3; 
    logic [63:0] wd3; 
    logic [63:0] rd1; 
    logic [63:0] rd2; 

    regfile dut (.clk(clk), .we3(we3), .ra1(ra1), .ra2(ra2), 
                 .wa3(wa3), .wd3(wd3), .rd1(rd1), .rd2(rd2));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // every 10ns
    end

    initial begin

        $display("----------- VERIFICAR VALORES INICIALES -----------");

        we3 = 0;

        for (int i = 0; i < 32; i++) begin
            ra1 = i;
            ra2 = i;
            @(negedge clk) begin
                if(rd1 != ((i == 5'b11111) ? 0 : i) || 
                   rd2 != ((i == 5'b11111) ? 0 : i))
                    $error("El registro %d deberia ser %d, pero rd1=%2h y rd2=%2h",
                            i, i, rd1, rd2);
                else
                    $display("Registro %d correcto: rd1=%2h y rd2=%2h", i, rd1, rd2);
            end
        end

        $display("----------- ESCRIBIR REGISTRO -----------");

        we3 = 1;
        wa3 = 5'b00001;
        wd3 = 64'h1;
        ra1 = 5'b00001;
        ra2 = 5'b00001;

        @(negedge clk) begin
            if(rd1 != wd3 || rd2 != wd3)
                $error("Fail: output expected = %2h, but rd1=%2h and rd2=%2h", wd3, rd1, rd2);
            else
                $display("Correct: output expected = %2h, rd1=%2h and rd2=%2h", wd3, rd1, rd2);
        end

        $display("----------- NO ESCRIBIR CON we3 = 0 -----------");

        we3 = 0;
        wa3 = 5'b00001;
        wd3 = 64'h0;
        ra1 = 5'b00001;

        @(negedge clk) begin
            if(rd1 != 64'h1)
                $error("Ilegal write: new value %2h, expected %2h, but rd1=%2h", wd3, 64'h1, rd1);
            else
                $display("Flag use correct: new value %2h, expected %2h, rd1=%2h", wd3, 64'h1, rd1);
        end
        
        $display("----------- X31 SIEMPRE EN 0 -----------");
        we3 = 1;
        wa3 = 5'b11111;
        wd3 = 64'hFF;
        ra1 = 5'b11111;
        ra2 = 5'b11111;

        @(negedge clk) begin
            if(rd1 != 0 || rd2 != 0)
                $error("X31 wrote: rd1=%2h and rd2=%2h", rd1, rd2);
            else
                $display("CORRECT: X31 = %2h", rd1);
        end

        $display("TESTBENCH FINISHED");
        $finish;

    end

endmodule
