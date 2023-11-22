module ALU (
    input [31:0]OP1,  //Operando 01
    input [31:0]OP2, //Operando 02
    input [3:0]Sel, //Selector 
    output ZF, //Zero Flag
    output reg[31:0]resultado //Resultado
);
    
always @(*) begin //Dependiendo del codigo que reciba del ALUcontrol es la operacion que se realizara
    case (Sel)
        4'b0000:  //Operacion AND
        resultado = OP1 & OP2;
        4'b0001:  //Operacion OR
        resultado = OP1 | OP2;
        4'b0010: //Operacion Suma
        resultado = OP1 + OP2;
        4'b0110:  //Operacion Resta 
        resultado = OP1 - OP2;
        4'b0111: // Operacion SLT
        resultado = (OP1 < OP2);
        4'b1100: //Operacion NOR
        resultado = ~(OP1 | OP2);
        default:
        resultado = 32'd0;
    endcase
end

assign ZF = (resultado == 0); //Zero flag que se activa (1) cuando el resultado de la ALU es 0

endmodule

