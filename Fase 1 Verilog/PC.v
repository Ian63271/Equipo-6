module PC(
    input[31:0]pcin,
    output reg[31:0] pcout
);

initial
    begin
        pcout=0;
    end
always @(*)
    begin
        pcout = pcin;
    end


endmodule