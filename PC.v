module PC(
    input[31:0]pcin,
    input clk,
    output reg[31:0] pcout
);

initial
    begin
        pcout=0;
    end
always @(posedge clk)
    begin
        pcout <= pcin;
    end


endmodule