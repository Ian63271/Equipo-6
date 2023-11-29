module PC(
    input[31:0]pcin,
    output reg[31:0] pcout
);

initial //Program counter, inciando desde 0 siempre la entrada es igual a su salida
    begin
        pcout=0;
    end
always @(*)
    begin
        pcout = pcin;
    end


endmodule