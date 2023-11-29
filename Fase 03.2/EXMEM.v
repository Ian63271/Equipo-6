module EXMEM(
    input clk,
    input [1:0]WB,
    input [2:0]M,
    input [31:0]BranchInst,
    input ZeroFlag,
    input [31:0]ALUresult,
    input [31:0]Dato2,
    input [4:0]DirWriteReg,

    output reg [1:0]O_WB,
    output reg [2:0]O_M,
    output reg O_Branch,
    output reg O_MemWrite,
    output reg O_MemRead,
    output reg [31:0]O_BranchInst,
    output reg O_ZeroFlag,
    output reg [31:0]O_ALUresult,
    output reg [31:0]O_Dato2,
    output reg [4:0]O_DirWriteReg
);

always @(*) begin
    O_WB = WB;
    O_MemRead = M[0];
    O_MemWrite = M[1];
    O_Branch = M[2]; 
    O_BranchInst = BranchInst;
    O_ZeroFlag = ZeroFlag;
    O_ALUresult = ALUresult;
    O_Dato2 = Dato2;
    O_DirWriteReg = DirWriteReg;

end

endmodule

