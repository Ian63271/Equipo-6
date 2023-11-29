module ProyectoFinalFase2 (input clk);

//Instrucciones
wire [31:0]instruccion;

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
reg [31:0]sum4pcout;

//Registros y ALU
wire [31:0]C1;
wire [31:0]C2;
wire [31:0]C3;
wire [3:0]C4;
wire [31:0]C5;
reg [31:0]MUX;
wire TRZF;

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

// Buffer IFID
wire  [31:0] IFID_sum4pcout_wire;

//Buffer IDEX
wire [1:0]IDEX_O_WB;
wire [3:0]IDEX_O_M;
wire IDEX_O_RegDst;
wire [1:0] IDEX_O_ALUop;
wire IDEX_O_ALUsrc; 
wire [31:0] IDEX_O_NextAddress;
wire [31:0] IDEX_O_OP1;
wire [31:0] IDEX_O_OP2;
wire [31:0] IDEX_O_SignExt;
wire [4:0] IDEX_O_RT;
wire [4:0] IDEX_O_RD;

//Buffer EXMEM
wire [1:0] EXMEM_O_WB;
wire [2:0] EXMEM_O_M;
wire EXMEM_O_Branch;
wire EXMEM_O_MemWrite;
wire EXMEM_O_MemRead;
wire [31:0] EXMEM_O_BranchInst;
wire EXMEM_O_ZeroFlag;
wire [31:0] EXMEM_O_ALUresult;
wire [31:0] EXMEM_O_Dato2;
wire [4:0] EXMEM_O_DirWriteReg;

//Buffer MEMWB
wire MEMWB_O_MemtoReg;
wire MEMWB_O_RegWrite;
wire [31:0] MEMWB_O_ReadData;
wire [31:0] MEMWB_O_ALUresult;
wire [4:0] MEMWB_O_DirWriteReg;


PC pCounter(
    .pcin(dir),
    .pcout(PcOUT)
);



MemINS MemInst(
    .readAddress(PcOUT),
    .Instruccion(instruccion) 
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
    .DirWrite(MEMWB_O_DirWriteReg),
    .DatoNuevo(MUX), //Es el dato que se escribe, resultado de la ALU.
    .Dato1(C2), //for some reason el cable2 se conecta al dato y viceversa.
    .Dato2(C1),
    .RWEN(MEMWB_O_RegWrite)
);

ALUControl ALUcon (
    .FuncIn(IDEX_O_SignExt [5:0]),
    .ALUOp(IDEX_O_ALUop),
    .ALUin(C4)
);

ALU ALUins (
    .OP1(IDEX_O_OP1),
    .OP2(op2),
    .Sel(C4),
    .ZF(TRZF),
    .resultado(C3)
);

MemRAM Mem(
    .rEn(EXMEM_O_MemRead),
    .wEn(EXMEM_O_MemWrite),
    .Adress(EXMEM_O_ALUresult),
    .DataWrite(EXMEM_O_Dato2),
    .DataRead(C5)
);

SignExtend SE(
    .preExt(Inst),
    .ext(SEInst)
);

IFID IFID(
	.clk(clk),
	.IFID_sum4pcout(sum4pcout),
	.IFID_instruccion(instruccion),
	.OP(OP),
	.RS(RS),
	.RT(RT),
	.RD(RD),
	.Shamt(Shamt),
	.Funct(Funct),
	.Inst(Inst),
	.IFID_sum4pcout_O(IFID_sum4pcout_wire)
);

IDEX IDEX(
    .clk(clk),
    //Conexiones de Unidad de Control a IDEX
    .WB({regwrite,memreg}),
    .M({branch,memwrite,memread}),
    .EX({alusrc,ALUop,regdst}),
    //Salidas de IDEX (señales de unidad de control)
    .O_WB(IDEX_O_WB),
    .O_M(IDEX_O_M),
    .O_RegDst(IDEX_O_RegDst),
    .O_ALUop(IDEX_O_ALUop),
    .O_ALUsrc(IDEX_O_ALUsrc),
    //Conexion PC a IDEX
    .NextAdress(IFID_sum4pcout_wire),
    .O_NextAdress(IDEX_O_NextAddress),
    //Conexiones Banco de registro a IDEX
    .OP1(C2),
    .OP2(C1),
    .O_OP1(IDEX_O_OP1),
    .O_OP2(IDEX_O_OP2),
    //Conexion Signextend
    .SignExt(SEInst),
    .O_SignExt(IDEX_O_SignExt),
    //Conexiones MUX(WriteReg) a IDEX
    .RT(RT),
    .RD(RD),
    .O_RT(IDEX_O_RT),
    .O_RD(IDEX_O_RD)
);

EXMEM EXMEM(
    .clk(clk),
    //Conexiones IDEX a EXMEM
    .WB(IDEX_O_WB),
    .O_WB(EXMEM_O_WB),

    .M(IDEX_O_M),
    .O_MemRead(EXMEM_O_MemRead),
    .O_MemWrite(EXMEM_O_MemWrite),
    .O_Branch(EXMEM_O_Branch),

    //Conexion ADD Branch a EXMEM
    .BranchInst(brALU),
    .O_BranchInst(EXMEM_O_BranchInst),

    //Conexion ALU a EXMEM
    .ZeroFlag(TRZF),
    .O_ZeroFlag(EXMEM_O_ZeroFlag),

    .ALUresult(C3),
    .O_ALUresult(EXMEM_O_ALUresult),

    //Conexion Registro a EXMEM
    .Dato2(C1),
    .O_Dato2(EXMEM_O_Dato2),

    //Conexion Mux(WriteRegister) a EXMEM
    .DirWriteReg(writereg),
    .O_DirWriteReg(EXMEM_O_DirWriteReg)
);

MEMWB MEMWB(
    .clk(clk),

    //Conexion de EXMEM a MEMWB
    .WB(EXMEM_O_MemWrite),
    .O_MemtoReg(MEMWB_O_MemtoReg),
    .O_RegWrite(MEMWB_O_RegWrite),

    //Conexion Memoria de dato a MEMWB
    .ReadData(C5),
    .O_ReadData(MEMWB_O_ReadData),

    //Conexoin ALU a MEMWB
    .ALUresult(EXMEM_O_ALUresult),
    .O_ALUresult(MEMWB_O_ALUresult),

    //Conexion Mux(WriteRegister) a MEMWB
    .DirWriteReg(EXMEM_O_DirWriteReg),
    .O_DirWriteReg(MEMWB_O_DirWriteReg)
);

always @(posedge clk) begin
    
	//Ciclo fetch para aumentar la direccion a la inruccion continua inmediata 
    sum4pcout <= PcOUT + 4; 
    
	//Sumador y selector para branch
	ANDpcmux = EXMEM_O_Branch & EXMEM_O_ZeroFlag;
    brALU <= IDEX_O_NextAddress + BitShiftInst;
	
end

always @(*) begin //MUX varios del dptr
    
    BitShiftInst <= IDEX_O_SignExt << 2; // bitshift a la izq en la instruccion ya extendida a 32 bits.

    case (MEMWB_O_MemtoReg)
        1'b0: 
            MUX = MEMWB_O_ALUresult;
        default: 
            MUX = MEMWB_O_ReadData;
        endcase

        case (IDEX_O_RegDst)
        1'b0: 
            writereg = IDEX_O_RT;
        default: 
            writereg = IDEX_O_RD;
        endcase

        case (IDEX_O_ALUsrc)
        1'b0: 
            op2 = IDEX_O_OP2;   
        default: 
            op2 = IDEX_O_SignExt;
        endcase

        case (ANDpcmux)
        1'b0: 
            dir = sum4pcout;
        default: 
            dir = EXMEM_O_BranchInst;
        endcase
end

endmodule
