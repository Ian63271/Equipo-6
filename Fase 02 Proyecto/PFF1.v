module ProyectoFinalFase1 (input clk);

//Instrucciones
wire [31:0]instruccion;

wire [5:0] OP;
wire [4:0] RS;
wire [4:0] RT;
wire [4:0] RD;
//wire [4:0] Shamt; //se elimina
wire [15:0] Funct;
wire [5:0] FunctR;

//PC
wire [31:0]dir;
wire [31:0]PcOUT;

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

//sign extend
wire [31:0] out32;

//Memoria de instrucciones
wire [31:0] c1WriteData;

// mux reg
wire [4:0]seleccionreg;

//mux alu
reg [31:0]op2;
wire [31:0] seleccionalu;

//mux memoria ram
wire [31:0] c3mux;
wire [31:0] MuxDatoNuevo;

//mux pc
reg [31:0] pcoutmux;
wire ORmux; 

//Add
wire [31:0] pcoutAdd;
wire [31:0] btmux;


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
    .DirWrite(seleccionreg),
    .DatoNuevo(MUX), //Es el dato que se escribe, resultado de la ALU.
    .Dato1(C2), //for some reason el cable2 se conecta al dato y viceversa.
    .Dato2(C1),
    .RWEN(regwrite)
);

ALUControl ALUcon (
    .FuncIn(FunctR),
    .ALUOp(ALUop),
    .ALUin(C4)
);

ALU ALUins (
    .OP1(C2),
    .OP2(seleccionalu),
    .Sel(C4),
    .ZF(TRZF),
    .resultado(C3)
);

MemRAM Mem(
    .rEn(memread),
    .wEn(memwrite),
    .Adress(C3),
    .DataWrite(c1WriteData),
    .DataRead(C5)
);

SignExtend signextend(
    .entrada16(Funct),
    .salida32(out32)
);

Mux21 muxreg(
    .opc1(RT),
    .opc2(RD),
    .select(regdst),
    .salida(seleccionreg)
);

Mux21 muxalu(
    .opc1(C1),
    .opc2(op2),
    .select(alusrc),
    .salida(seleccionalu)
);

Mux21 muxram(
    .opc1(C5),
    .opc2(c3mux),
    .select(memreg),
    .salida(MuxDatoNuevo)
);

Add Add(
    .entrada1(pcoutAdd),
    .entrada2(out32),
    .Branchtarget(btmux)
);

Mux21 muxpc(
    .opc1(pcoutmux),
    .opc2(btmux),
    .select(ORmux),
    .salida(dir)
);

// initial begin
//        $readmemb("output.txt",MemInst.INS);
// end

assign OP = instruccion [31:26];
assign RS = instruccion [25:21];
assign RT = instruccion [20:16];
assign RD = instruccion [15:11];
//assign Shamt = instruccion [10:6];
assign Funct = instruccion [15:0];
assign FunctR = Funct [5:0];

assign op2 = out32;
assign c1WriteData = C1;
assign c3mux = C3;  
assign pcoutAdd = pcoutmux;
assign ORmux = branch | TRZF;

always @(posedge clk) begin
    
    pcoutmux <= PcOUT + 4; //se suma 4 a la direccion, esto entrara al PC



end
/*
always @(*) begin //MUX varios del dptr
    case (memreg)
        1'b0: 
            MUX = C3;
        default: 
            MUX = 32'd0;
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
            op2 = 32'd0;
    endcase
end
*/
endmodule

