module ProyectoFinalFase2 (input clk);

//Instrucciones
wire [31:0]instruccion;
wire [31:0]ifid_instruccion;

wire [5:0] OP;
wire [4:0] RS;
wire [4:0] RT;
wire [4:0] RD;
wire [4:0] Shamt;
wire [5:0] Funct;
wire [15:0] Inst;
wire [31:0] SEInst;

//PC
reg [31:0]dir;
wire [31:0]PcOUT;
wire [31:0]PcOUT_in;
wire [31:0]sum4pcout;
reg [31:0]ifid_sum4pcout;

//Registros y ALU
wire [31:0]C1;
wire [31:0]C2;
wire [31:0]C3;
wire [3:0]C4;
wire [31:0]C5;
reg [31:0]MUX;

//Control Unit
wire regdst; // de control unit al mux1
wire branch;
wire regwrite;
wire memwrite;
wire memread;
wire memreg;
wire [1:0]ALUop;
wire alusrc;

// mux reg
reg [4:0]writereg;

//mux alu
reg [31:0]op2;

//mux pc
reg ANDpcmux;
reg [31:0]brALU;
reg [31:0]BitShiftInst;

PC pCounter(
    .clk(clk),
    .pcin(dir),
    .pcout(PcOUT)
);


MemINS MemInst(
    .readAddress(PcOUT),
    .Instruccion(ifid_instruccion) 
);


IFID ifid(
	.clk(clk),
	.IFID_sum4pcout(ifid_sum4pcout),
	.IFID_instruccion(ifid_instruccion),
	.sum4pcout(sum4pcout),
	.instruccion(instruccion)
);

ControlUnit CU (
    .opcode(OP),
    .regDst(regdst),
    .branch(branch),
    .MemToRead(memread),
    .MemToReg(memreg),
    .ALUOp(ALUop),
    .MemToWrite(memwrite),
    .ALUSrc(alusrc),
    .RegWrite(regwrite)
);

MemREG Register (
    .Dir1(RS),
    .Dir2(RT),
    .DirWrite(writereg),
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
    .OP2(op2),
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

SignExtend SE(
    .preExt(Inst),
    .ext(SEInst)
);



// initial begin
//        $readmemb("output.txt",MemInst.INS);
// end

assign OP = instruccion [31:26];
assign RS = instruccion [25:21];
assign RT = instruccion [20:16];
assign RD = instruccion [15:11];
assign Shamt = instruccion [10:6];
assign Funct = instruccion [5:0];
assign Inst = instruccion [15:0];

always @(posedge clk) begin
    
    ifid_sum4pcout = PcOUT + 4; //se suma 4 a la direccion, esto entrara al PC
    ANDpcmux = branch & TRZF;
    brALU <= sum4pcout + BitShiftInst;
end

always @(*) begin //MUX varios del dptr
    
    BitShiftInst <= SEInst << 2; // bitshift a la izq en la instruccion ya extendida a 32 bits.

    case (memreg)
        1'b0: 
            MUX = C3;
        default: 
            MUX = C5;
        endcase

        case (regdst)
        1'b0: 
            writereg = RT;
        default: 
            writereg = RD;
        endcase

        case (alusrc)
        1'b0: 
            op2 = C1;   
        default: 
            op2 = SEInst;
        endcase

        case (ANDpcmux)
        1'b0: 
            dir = sum4pcout;
        default: 
            dir = brALU;
        endcase
end

endmodule
