module IFID(
    input clk,
    input [31:0]IFID_sum4pcout,
    input [31:0]IFID_instruccion,
    output reg [31:0]sum4pcout,
    output reg[31:0]instruccion
);

always @(*) begin
    sum4pcout = IFID_sum4pcout;
    instruccion = IFID_instruccion;
end

endmodule