`timescale 1ns/1ns
module DPTR_TB();

reg [31:0]readAddress_TB;
wire[31:0] Instruccion_TB;

InstructionMem DUV(
    .readAddress(readAddress_TB),
    .Instruccion(Instruccion_TB)
);

initial begin
readAddress_TB = 32'b00000000101001100000100000100000;
#100;

$stop;
end

endmodule

