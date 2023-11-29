module MemINS (
    input [31:0] readAddress,
    output reg [31:0] Instruccion
);
    
reg [7:0] INS [0:255];

always @(*) begin //Se concatena las 4 espacios seguidos de 8 bits en una  instruccion completa de 32 bits
    Instruccion = {INS[readAddress], INS[readAddress + 1], INS[readAddress + 2], INS[readAddress + 3]};
end

endmodule