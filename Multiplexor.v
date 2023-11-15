module multiplexor (
    input [31:0] dato1,
    input [31:0] dato2,
    input sel,
    output reg [31:0] muxOut
);

always @(*) begin
    case (sel)
        1'b0: muxOut = dato1;
        1'b1: muxOut = dato2;
        default: muxOut = 32'd0;
    endcase
end

endmodule
