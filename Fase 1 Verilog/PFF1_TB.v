`timescale 1ns/1ns
module PFF1_TB();

reg clk_TB;

ProyectoFinalFase1 DUV(
    .clk(clk_TB)
);

initial begin
    $readmemb("output.txt",DUV.MemInst.INS);
end 

initial begin
        clk_TB = 0;
        forever #100 clk_TB = ~clk_TB; // Toggle the clock every 10 time units
    end

endmodule

