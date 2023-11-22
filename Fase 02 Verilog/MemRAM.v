module MemRAM (
    input rEn,
    input wEn,
    input [31:0]Adress,
    input [31:0]DataWrite,
    output reg [31:0]DataRead
);
    
reg [31:0] RAM [0:255];
 
always @(*) begin //Memoria de datos, se puede deshabilitar leer y escribir
    if (rEn == 1'b1) begin
        RAM[Adress] = DataWrite;
    end 

    if (wEn == 1'b1) begin 
        DataRead = RAM[Adress];
    end

    if (wEn == rEn) begin //Si esta tanto como pare leer y escribir se desactiva la lectura de memoria.
        DataRead = 32'b0;
    end
end

endmodule


/* EN ESTE CASO O LEE O ESCRIBE, EN LO IMPLEMENTADOS SIEMPRE LEE, PERO CUANDO RWEN ES 1 ESCRIBE.
always @(*) begin
    if (RWEN == 1'b1) begin
        RAM[DirWrite] = DatoNuevo;
    end else begin
        Dato1 = RAM[Dir1];
        Dato2 = RAM[Dir2];
    end
end
*/