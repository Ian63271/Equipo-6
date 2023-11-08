module ControlUnit (
    input [5:0]opcode,
    output reg MemToReg,
    output reg MemToWrite,
    output reg [1:0]ALUOp,
    output reg RegWrite
);

always @(*) begin //cada caso sera un tipo de instruccion diferente.
    case (opcode)
        6'b000000: begin //se usa el begin y end porque por cualquier razon no deja asignar señales de un bit sin esto.
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            ALUOp = 2'b10; 
            RegWrite = 1'b1;
        end
        default: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            ALUOp = 2'b00; 
            RegWrite = 1'b0;
        end
    endcase
end

endmodule

//Esta version se usa un ternario, pero como se usara a futuro el memtowrite, memtoreg y regwrite se usa mejor la version con case.
/*always @(*) begin 
    case (opcode)
        6'b000000:
            ALUOp = 2'b10; 
        default:
            ALUOp = 2'b00; 
    endcase
end*/

/*assign MemToReg = 0;
assign MemToWrite = 0;
assign RegWrite = (opcode == 6'b000000) ? 1 : 0;*/
