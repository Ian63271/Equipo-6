module IDEX(
    input clk,
    input [1:0]WB,
    input [2:0]M,
    input [3:0]EX,
    input [31:0]NextAdress,
    input [31:0]OP1,
    input [31:0]OP2,
    input [31:0]SignExt,
    input [4:0]RT,
    input [4:0]RD,
    output reg [1:0]O_WB,
    output reg [2:0]O_M,
    output reg O_RegDst,
    output reg [1:0]O_ALUop,
    output reg O_ALUsrc,
    output reg [31:0]O_NextAdress,
    output reg [31:0]O_OP1,
    output reg [31:0]O_OP2,
    output reg [31:0]O_SignExt,
    output reg [4:0]O_RT,
    output reg [4:0]O_RD
);

always @(posedge clk ) begin
    O_WB = WB;
    O_M = M;
    O_RegDst = EX[0];
    O_ALUop = EX[2:1];
    O_ALUsrc = EX[3]; 
    O_NextAdress = NextAdress;
    O_OP1 = OP1;
    O_OP2 = OP2;
    O_SignExt = SignExt;
    O_RT = RT;
    O_RD = RD;
end

endmodule
