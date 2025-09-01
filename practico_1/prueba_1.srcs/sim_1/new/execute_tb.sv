`timescale 1ns / 1ps

module execute_tb;
    logic ALUSrc;
    logic [3:0] ALUControl;
    logic [63:0] PC_E, signImm_E, readData1_E, readData2_E;
    logic [63:0] PCBranch_E, aluResult_E, writeData_E;
    logic zero_E;

    execute dut (.ALUSrc(ALUSrc), .ALUControl(ALUControl), .PC_E(PC_E),
                 .signImm_E(signImm_E), .readData1_E(readData1_E),
                 .readData2_E(readData2_E), .PCBranch_E(PCBranch_E),
                 .aluResult_E(aluResult_E), .writeData_E(writeData_E),
                 .zero_E(zero_E));

    function automatic prints (input logic fail_sentence);
        
        if(fail_sentence)
            $display("Bad execute");
        else
            $display("Correct execute");

        $display("PC = %3h, aluRes = %2h, zero = %2h, writeData = %2h", 
                  PCBranch_E, aluResult_E, zero_E, writeData_E);

    endfunction

    initial begin
        PC_E = 64'h100;
        signImm_E = 64'h10;
        readData1_E = 64'h40;
        readData2_E = 64'h20;

        ALUSrc = 0;
        ALUControl = 4'b0000;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h0 ||
               zero_E != 1 || writeData_E != readData2_E);

        ALUControl = 4'b0001;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h60 ||
               zero_E != 0 || writeData_E != readData2_E);
        
        ALUControl = 4'b0010;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h60 ||
               zero_E != 0 || writeData_E != readData2_E);
        
        ALUControl = 4'b0110;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h20 ||
               zero_E != 0 || writeData_E != readData2_E);
        
        ALUControl = 4'b0111;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h20 ||
               zero_E != 0 || writeData_E != readData2_E);

        ALUControl = 4'b0011;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h0 ||
               zero_E != 1 || writeData_E != readData2_E);

        ALUSrc = 1;

        ALUControl = 4'b0000;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h0 ||
               zero_E != 1 || writeData_E != readData2_E);

        ALUControl = 4'b0001;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h50 ||
               zero_E != 0 || writeData_E != readData2_E);
        
        ALUControl = 4'b0010;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h50 ||
               zero_E != 0 || writeData_E != readData2_E);
        
        ALUControl = 4'b0110;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h30 ||
               zero_E != 0 || writeData_E != readData2_E);
        
        ALUControl = 4'b0111;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h10 ||
               zero_E != 0 || writeData_E != readData2_E);

        ALUControl = 4'b0011;
        #1;

        prints(PCBranch_E != 64'h140 || aluResult_E != 64'h0 ||
               zero_E != 1 || writeData_E != readData2_E);
            
        $display("FINISH TEST");
        $finish;
    end

endmodule
