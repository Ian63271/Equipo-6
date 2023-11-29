module IFID (
input clk,
input  [31:0] IFID_sum4pcout,
output reg [31:0] IFID_sum4pcout_O,
input  [31:0] IFID_instruccion,
output reg  [31:0] IFID_instruccion_O
);

always @(*) begin
	//Buffer IFID
	IFID_sum4pcout_O = IFID_sum4pcout;
	IFID_instruccion_O = IFID_instruccion;
end

endmodule