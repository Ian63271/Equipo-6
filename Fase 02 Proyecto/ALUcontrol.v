module ALUControl (
    input [5:0]FuncIn, //Entrada que trae el campo Function de la instruccion 
    input [1:0]ALUOp, //Entrada que trae el codigo para ALU op (proviene de Control Unit -> ALUOp)
    output reg [3:0]ALUin //Salida que da el codigo para seleccionar operacion en la ALU (conectada a ALU -> Sel)
);


always @(*) begin
    if (ALUOp == 2'b10) begin //Dependiendo del function que reciba de la instruccion es lo que saldra, esto se envia la ALU
        case (FuncIn)
            6'b100000:
                ALUin = 4'b0010; //SUMA
            6'b100010:
                ALUin = 4'b0110;
            6'b100100:
                ALUin = 4'b0000;
            6'b100101:
                ALUin = 4'b0001;
            6'b101010:
                ALUin = 4'b0111; 
        endcase
    end

    if (ALUOp == 2'b00) begin
        ALUin = 4'b0010; //SUMA
    end
end


endmodule
