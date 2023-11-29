module IFID (
input clk,
input  [31:0] IFID_sum4pcout,
output reg [31:0] IFID_sum4pcout_O,
input  [31:0] IFID_instruccion,
output reg [31:26] OP,
output reg [25:21] RS,
output reg [20:16] RT,
output reg [15:11] RD,
output reg [10:6] Shamt,
output reg [5:0] Funct,
output reg [15:0] Inst

);

always @(posedge clk) begin
	//Buffer IFID
	IFID_sum4pcout_O = IFID_sum4pcout;
	OP = IFID_instruccion[31:26];
	RS = IFID_instruccion[25:21];
	RT = IFID_instruccion[20:16];
	RD = IFID_instruccion[15:11];
	Shamt = IFID_instruccion[10:6];
	Funct = IFID_instruccion[5:0];
	Inst = IFID_instruccion[15:0];
	
end

endmodule