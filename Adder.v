module Adder(
    input [31:0] pcsum, // ¿Cuántos bits se supone que entran? 32?
    output reg[31:0] suma
);

reg [3:0] sig; 

assign sig = 4'b0100; 

always @(*) begin
    suma = pcsum + sig;
end

endmodule
