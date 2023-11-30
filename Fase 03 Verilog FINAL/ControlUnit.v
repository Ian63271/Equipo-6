module ControlUnit (
    input [5:0]opcode, // lo que recibe de la instruccion
    output reg regDst, // indica de donde se escribe en el registro
    output reg branch, // indica si se hara un salto
    output reg MemToRead, //no se usa en esta fase, si se lee de memoria
    output reg MemToReg, // este ahora va al mux, si se sacara de la memoria al registro
    output reg [1:0]ALUOp, //codigo para la alu control, esto sirve para type r, sw y lw.
    output reg MemToWrite, //no se usa en esta fase
    output reg ALUSrc, //de donde recibe la alu su segundo operando
    output reg RegWrite, //si se escribe en el registro
    output reg Jump
    
    
);

always @(*) begin //cada caso sera un tipo de instruccion diferente.
    case (opcode)
        6'b000000: begin //se usa el begin y end porque por cualquier razon no deja asignar señales de un bit sin esto.
            MemToReg = 1'b0; 
            regDst = 1'b1;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b0;      /// que hacia branch? // se usa para condicionales
            ALUOp = 2'b10; 
            ALUSrc = 1'b0; 
            RegWrite = 1'b1;
            Jump = 1'b0;
        end
        6'b001000: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b0; 
            ALUOp = 2'b00; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b1;
            regDst = 1'b0;
            Jump = 1'b0;
        end
        6'b001100: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b0; 
            ALUOp = 2'b00; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b1;
            regDst = 1'b0;
            Jump = 1'b0;
        end
        6'b001101: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b0; 
            ALUOp = 2'b00; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b1;
            regDst = 1'b0;
            Jump = 1'b0;
        end
        6'b001010: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b0; 
            ALUOp = 2'b11; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b1;
            regDst = 1'b0;
            Jump = 1'b0;
        end
        6'b100011: begin
            MemToReg = 1'b1;
            MemToWrite = 1'b0;
            MemToRead = 1'b1;
            branch = 1'b0; 
            ALUOp = 2'b00; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b1;
            regDst = 1'b0;
            Jump = 1'b0;
        end
        6'b101011: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b1;
            MemToRead = 1'b0;
            branch = 1'b0; 
            ALUOp = 2'b00; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b0;
            regDst = 1'b0;
            Jump = 1'b0;
        end
        6'b000100: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b1; 
            ALUOp = 2'b01; 
            ALUSrc = 1'b0; 
            RegWrite = 1'b0;
            regDst = 1'b0;
            Jump = 1'b0;
        end
        6'b000010: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b1; 
            ALUOp = 2'b01; 
            ALUSrc = 1'b0; 
            RegWrite = 1'b0;
            regDst = 1'b0;
            Jump = 1'b1;
        end
        default: begin
            MemToReg = 1'b0;
            MemToWrite = 1'b0;
            MemToRead = 1'b0;
            branch = 1'b0; 
            ALUOp = 2'b00; 
            ALUSrc = 1'b0; 
            RegWrite = 1'b0;
            regDst = 1'b0;
            Jump = 1'b0;
        end
    endcase
end

endmodule