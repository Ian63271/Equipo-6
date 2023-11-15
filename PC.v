module PC(
    input[31:0]pcin,
    input clk,
    output reg[31:0] pcout
);

//proceso para actualizar el PC en cada flanco de subida del reloj
always @(posedge clk) begin
    if (clk) begin
        // Si hay un clk reiniciar el PC 
        pcout <= 32'b0; 
    end else begin
        // Incrementar el PC en cada iteracion
        pcout = pcin;
    end
end


endmodule