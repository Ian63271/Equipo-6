module MemREG (
    input RWEN, //entrada que habilita la escritura dentro del banco de registros (proviene de control Unit -> RegWrite por medio de Pff1 -> regwrite)
    input [4:0]Dir1, //Direccion numero 1 a leer 
    input [4:0]Dir2, //Direccion numero 2 a leer 
    input [4:0]DirWrite, //Direccion en la que se escribira 
    input [31:0]DatoNuevo, //Daro que se escribira 
    output reg [31:0]Dato1, //Primer dato leido 
    output reg [31:0]Dato2 //Segundo dato eido 
);
    
reg [31:0] REG [0:31];

initial begin //Banco de registros precargados, mismos datos que actividad 9
    REG[5] = 32'd10;    
    REG[6] = 32'd15;
    REG[7] = 32'd20;
    REG[8] = 32'd25;
    REG[9] = 32'd30;
    REG[10] = 32'd35;
    REG[11] = 32'd40;
    REG[12] = 32'd45;
    REG[13] = 32'd50;
    REG[14] = 32'd55;
    REG[15] = 32'd60;
    REG[16] = 32'd65;
    REG[17] = 32'd70;
    REG[18] = 32'd75;
    REG[19] = 32'd80;
    REG[20] = 32'd85;
    REG[21] = 32'd90;
    REG[22] = 32'd95;
    REG[23] = 32'd100;
    REG[24] = 32'd105;
    REG[25] = 32'd110;
    REG[26] = 32'd115;
    REG[27] = 32'd120;
    REG[28] = 32'd125;
    REG[29] = 32'd130;
    REG[30] = 32'd135;
    REG[31] = 32'd140;
    REG[32] = 32'd145;
end 

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
