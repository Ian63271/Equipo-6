module MEMWB(
    input clk,
    input [1:0]WB, 
    input [31:0]ReadData,
    input [31:0]ALUresult,
    input [4:0]DirWriteReg,

    output reg O_MemtoReg,
    output reg O_RegWrite,
    output reg [31:0]O_ReadData,
    output reg [31:0]O_ALUresult,
    output reg [4:0]O_DirWriteReg
);

always @(posedge clk ) begin
    O_MemtoReg = WB[0]; 
    O_RegWrite = WB[1]; 
    O_ReadData = ReadData;
    O_ALUresult = ALUresult;
    O_DirWriteReg = DirWriteReg;

end

endmodule
