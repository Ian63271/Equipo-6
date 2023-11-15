module InstructionMem (
    input [7:0] readAddress,
    output reg [31:0] Instruccion
);
    
reg [31:0] RAM [0:255];
 
always @(*) begin
    // Asegurar que la dirección no exceda el tamaño de la memoria
    if (readAddress < 256) begin
        Instruccion = RAM[readAddress];
    end 
    else begin
        // Manejar un error o tomar alguna acción predeterminada
        Instruccion = 32'b0;
    end
end

endmodule
