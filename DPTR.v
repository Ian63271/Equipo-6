module DPTR (
    input [31:0] instruccion,
    output TRZF
);

wire [5:0] OP;
wire [4:0] RS;
wire [4:0] RT;
wire [4:0] RD;
wire [4:0] Shamt;
wire [5:0] Funct;

assign OP = instruccion [31:26];
assign RS = instruccion [25:21];
assign RT = instruccion [20:16];
assign RD = instruccion [15:11];
assign Shamt = instruccion [10:6];
assign Funct = instruccion [5:0];

wire [31:0]C1;
wire [31:0]C2;
wire [31:0]C3;
wire [3:0]C4;
wire [31:0]C5;
reg [31:0]MUX;
wire regwrite;
wire [1:0]ALUop;
wire memwrite;
wire memread;
wire memreg;

ControlUnit CU (
    .opcode(OP),
    .RegWrite(regwrite),
    .MemToWrite(memwrite),
    .MemToRead(memread),
    .MemToReg(memreg),
    .ALUOp(ALUop)
);

MemREG Register (
    .Dir1(RS),
    .Dir2(RT),
    .DirWrite(RD),
    .DatoNuevo(MUX), //Es el dato que se escribe, resultado de la ALU.
    .Dato1(C2), //for some reason el cable2 se conecta al dato y viceversa.
    .Dato2(C1),
    .RWEN(regwrite)
);

ALUControl ALUcon (
    .FuncIn(Funct),
    .ALUOp(ALUop),
    .ALUin(C4)
);

ALU ALUins (
    .OP1(C2),
    .OP2(C1),
    .Sel(C4),
    .ZF(TRZF),
    .resultado(C3)
);

MemRAM Mem(
    .rEn(memread),
    .wEn(memwrite),
    .Adress(C3),
    .DataWrite(C1),
    .DataRead(C5)
);

always @(*) begin
    case (memreg)
        1'b0: 
            MUX = C3;
        default: 
            MUX = 32'd0;
    endcase
end

endmodule
