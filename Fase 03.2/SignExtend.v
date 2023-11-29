module SignExtend(
    input [15:0]preExt,
    output [31:0]ext
);

assign ext = { {16 {preExt[15]}}, preExt};

endmodule