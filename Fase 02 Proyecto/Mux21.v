
module Mux21 (
    input [31:0] opc1, //opcion numero 1
    input [31:0] opc2, //opcion numero 2
    input select, //Selector 
    output reg [31:0] salida //Salida que dara la opcion seleccionada 
);

always @(*) begin

    if (select == 1'b1) begin
        salida = opc1;
    end else begin
        salida = opc2;
    end
end
    
endmodule