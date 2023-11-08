module ALU (
    input [31:0]OP1,
    input [31:0]OP2,
    input [3:0]Sel,
    output ZF,
    output reg[31:0]resultado
);
    
always @(*) begin
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
        resultado = OP1 < OP2 ? 1 : 0;
        4'b1100:
        resultado = ~(OP1 | OP2);
        default:
        resultado = 32'd0;
    endcase
end

assign ZF = (resultado == 0) ? 1 : 0;

endmodule

/*if (operacion == "add") {
    opcode == 000000
    function = 100000
} */
