module PC(
    input[31:0]pcin,
    //input clk,
    //input reset,
    output reg[31:0] pcout
);

// proceso para actualizar el PC en cada flanco de subida del reloj
// always @(posedge clk or posedge reset) begin
//     if (reset) begin
//         // Si hay un reset reiniciar el PC 
//         pcout <= 32'b0; 
//     end else begin
//         // Incrementar el PC en cada flanco de subida del reloj
//         pcout <= pcin + 1;
//     end
// end

//habrá pulsos de reloj? o solo contará como tal?
//pendiente

endmodule