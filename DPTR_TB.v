`timescale 1ns/1ns
module DPTR_TB();

reg [31:0]instruccion_TB;
wire TRZF_TB;

DPTR DUV(
    .instruccion(instruccion_TB),
    .TRZF(TRZF_TB)
);

initial begin
instruccion_TB = 32'b00000000101001100000100000100000;
#100;
instruccion_TB = 32'b00000000001010100000000000100000;
#100;
instruccion_TB = 32'b00000000001010000001000000100010;
#100;
instruccion_TB = 32'b00000001110000000010000000100010;
#100;
instruccion_TB = 32'b00000001010101010001100000100100;
#100;
instruccion_TB = 32'b00000011110011110001000000100100;
#100;
instruccion_TB = 32'b00000000011001001111100000100101;
#100;
instruccion_TB = 32'b00000000000000011111000000100101;
#100;
instruccion_TB = 32'b00000000101111011001100000101010;
#100;
instruccion_TB = 32'b00000000000000011011100000101010;
#100;
$stop;
end

endmodule

