`timescale 1ns/1ns
module PFF2_TB();

reg clk_TB;

ProyectoFinalFase2 DUV(
    .clk(clk_TB)
);

initial begin //se carga las instrucciones a la memoria de datos
    $readmemb("output.txt",DUV.MemInst.INS);
    $readmemb("memram.txt",DUV.Mem.RAM);
end 

initial begin //se crea un ciclo infinito donde se alterna entre 0 y 1 el clk, asi haciendo funcionar nuestro ciclo de posedge clk
        clk_TB = 0;
        forever #100 clk_TB = ~clk_TB; // Toggle the clock every 10 time units
    end

endmodule

