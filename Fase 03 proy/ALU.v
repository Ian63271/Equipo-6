module ALU (
    input [31:0]OP1,
    input [31:0]OP2,
    input [3:0]Sel,
    output ZF,
    output reg[31:0]resultado
);
    
always @(*) begin //Dependiendo del codigo que reciba del ALUcontrol es la operacion que se realizara
    case (Sel)
        4'b0000:
        resultado = OP1 & OP2;
        4'b0001:
        resultado = OP1 | OP2;
        4'b0010:
        resultado = OP1 + OP2;
        4'b0110:
        resultado = OP1 - OP2;
        4'b0111:
        resultado = (OP1 < OP2);
        4'b1100:
        resultado = ~(OP1 | OP2);
        default:
        resultado = 32'd0;
    endcase
end

assign ZF = (resultado == 0); //Zero flag que se activa (1) cuando el resultado de la ALU es 0

endmodule
