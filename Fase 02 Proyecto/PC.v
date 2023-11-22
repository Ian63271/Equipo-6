
module PC(
    input[31:0]pcin, //Entrada que recibe la nueva direccion que debera leer en la memoria de intrucciones (priviene de PFF1 -> dir)
    output reg[31:0] pcout //Salida que dara la nueva direccion a leer (conectada a MemINS -> readAddress por medio de PFF1 -> PcOUT)
);

initial //Program counter, inciando desde 0 siempre la entrada es igual a su salida
    begin
        pcout=0;
    end
always @(*)
    begin
        pcout = pcin;
    end


endmodule
