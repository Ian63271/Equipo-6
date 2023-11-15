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

reg [31:0] mux2ToAlu;
reg [31:0] mux4ToPc;
reg [31:0]mux1ToWriteRegister;
reg [31:0]mux3toDatoNuevo;

wire [31:0]C1;
wire [31:0]C2;
wire [31:0]C3;
wire [3:0]C4;

wire [31:0] regdst; // de control unit al mux1
wire branch;
wire [1:0]ALUop;
wire alusrc;
wire memreg;
wire mux4and;
wire [31:0] PcToInsMem;
wire [31:0]sumToMux4;
//wire [31:0]C5; // NO SE USA EN FASE 1 PORQUE NO HAY MEM DE DATOS
//wire [4:0] RtToMux; //de la instruccion [20-16] al MUX  AUN NO SE USA
//wire regwrite;
//wire memwrite;
//wire memread;

//00000000101001100000100000100000

assign mux4and = TRZF & branch; //asignamos compuerta AND


        //ciclo fetch
PC pCounter(
    .pcin(mux4ToPc),
    .pcout(PcToInsMem)
);

// multiplexor mux4(
//     .dato1(sumToMux4),
//     .dato2(),   // no definido aun
//     .sel(mux4and),
//     .muxOut(mux4ToPc)
// );

InstructionMem Minstrucciones(
    .readAddress(PcToInsMem),
    .Instruccion(instruccion) //conectado al instruccion del DPTR??
);

Adder sumador(
    .pcsum(PcToInsMem),
    .suma(sumToMux4)    
);

        //fin del ciclo fetch


ControlUnit CU (
    .opcode(OP), //input de la instruccion [31:26]
    .regDst(regdst), 
    .branch(branch),
    .MemToReg(memreg),
    .ALUOp(ALUop),
    .ALUSrc(alusrc),
    .RegWrite(regwrite)
);

// multiplexor mux1( //recibe la instruccion del RD[15:11] y regDst
//     .dato1(),
//     .dato2(RD), //de cuantos bits deben ser las entradas?
//     .sel(regdst),
//     .muxOut(mux1ToWriteRegister) //de cuantos bits?
// );

MemREG Register (
    .Dir1(RS),
    .Dir2(RT),
    .DirWrite(mux1ToWriteRegister),  //de cuantos bits el DirWrite ????
    .DatoNuevo(mux3toDatoNuevo), //Es el dato que se escribe, resultado de la ALU.
    .Dato1(C2), 
    .Dato2(C1),
    .RWEN(regwrite)
);

// multiplexor mux2(
//     .dato1(C1),
//     .dato2(),   //no esta definido aun ???
//     .sel(ALUSrc),
//     .muxOut(mux2ToAlu)
// );

// multiplexor mux3(
//     .dato1(), //no hay entrada definida aun ???
//     .dato2(C3),
//     .sel(memtoreg),
//     .muxOut(mux3toDatoNuevo)
// );

ALUControl ALUcon (
    .FuncIn(Funct),
    .ALUOp(ALUop),
    .ALUin(C4)
);

ALU ALUins (
    .OP1(C2),
    .OP2(mux2ToAlu),
    .Sel(C4),
    .ZF(TRZF),
    .resultado(C3)
);

// MemRAM Mem(
//     .rEn(memread),
//     .wEn(memwrite),
//     .Adress(C3),
//     .DataWrite(C1),
//     .DataRead(C5)
// );


 always @(*) begin  //mux1 que recibe instruccion de [15:11]
    case(regdst)    // de control unit al mux1
        1'b0:
            mux1ToWriteRegister = RD;
        default:
            mux1ToWriteRegister = 32'd0;
    endcase

 end

always @(*) begin       //mux2 del registro al alu
    case(alusrc)
        1'b0:
            mux2ToAlu = C1;
        default:
            mux2ToAlu = 32'd0;
    endcase
 end

always @(*) begin       //MUX3 del alu al writedata del registro
    case (memreg) //selector
        1'b0: 
            mux3toDatoNuevo = C3;
        default: 
            mux3toDatoNuevo = 32'd0;
    endcase
end

always @(*) begin       //mux4  (ciclo fetch)
    case(mux4and)
        1'b0:
            mux4ToPc = sumToMux4;
        default:
            mux4ToPc = 32'd0;
    endcase
 end



endmodule
