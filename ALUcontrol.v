module ALUControl (
    input [5:0]FuncIn,
    input [1:0]ALUOp,
    output reg [3:0]ALUin
);


always @(*) begin
    if (ALUOp == 2'b10) begin
        case (FuncIn)
            6'b100000:
                ALUin = 4'b0010;
            6'b100010:
                ALUin = 4'b0110;
            6'b100100:
                ALUin = 4'b0000;
            6'b100101:
                ALUin = 4'b0001;
            6'b101010:
                ALUin = 4'b0111; 
        endcase
    end
end


endmodule