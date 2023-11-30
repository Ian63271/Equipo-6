module MemREG (
    input RWEN,
    input [4:0]Dir1,
    input [4:0]Dir2,
    input [4:0]DirWrite,
    input [31:0]DatoNuevo,
    output reg [31:0]Dato1,
    output reg [31:0]Dato2
);
    
reg [31:0] REG [0:31];

always @(*) begin
    if (RWEN == 1'b1) begin
        REG[DirWrite] = DatoNuevo;
    end 
        Dato1 = REG[Dir1];
        Dato2 = REG[Dir2];
end

endmodule


/* EN ESTE CASO O LEE O ESCRIBE, EN LO IMPLEMENTADOS SIEMPRE LEE, PERO CUANDO RWEN ES 1 ESCRIBE.
always @(*) begin
    if (RWEN == 1'b1) begin
        REG[DirWrite] = DatoNuevo;
    end else begin
        Dato1 = REG[Dir1];
        Dato2 = REG[Dir2];
    end
end
*/