module Adder(
    input[31:0] pcsum, //cuantos bits se supone que entran? 32?
    
    output reg suma
);

wire[3:0] sig, ///??? wire o reg?

assign sig = 4'b4;

always @(*) begin
assign suma = pcsum + sig;
end

endmodule