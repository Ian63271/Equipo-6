module MemINS (
    input [31:0] readAddress, //Entrada que contiene la direccion de memoria a leer (proviene de PC -> pcout por medio de PFF1 -> PcOUT)
    output reg [31:0] Instruccion //Salida con la instruccion leida (conectada a PFF1 -> instruccion el cual se divide en distintos cables)
);
    
reg [7:0] INS [0:255];

always @(*) begin //Se concatena las 4 espacios seguidos de 8 bits en una  instruccion completa de 32 bits
    Instruccion = {INS[readAddress], INS[readAddress + 1], INS[readAddress + 2], INS[readAddress + 3]};
end

endmodule
