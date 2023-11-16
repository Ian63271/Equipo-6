module MemINS (
    input [31:0] readAddress,
    output reg [31:0] Instruccion
);
    
reg [7:0] INS [0:255];
 
always @(*) begin
    Instruccion = {INS[readAddress], INS[readAddress + 1], INS[readAddress + 2], INS[readAddress + 3]};
end

endmodule