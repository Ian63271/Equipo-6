
module SignExtend (
    input [15:0] entrada16, //Entrada de 16 bits 
    output reg [31:0] salida32 //Salida con la entrada extendida a 32 bits
);
    
always @(*) begin
    salida32 = {{16{entrada16[15]}}, entrada16}; //Se concatenan 16 veces el bits mas significativo de la entrada a la entrada
end

endmodule
