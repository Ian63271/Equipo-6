module Add (
    input [31:0] entrada1, // Primera entrada que trae la dirección de PC previamente sumada con 4 
    input [31:0] entrada2, // Instrucción extendida a 32 bits
    output [31:0] Branchtarget // Salida con la suma realizada
);

    // Shift left 2 bits
    assign entrada2 = entrada2 << 2; 

    // Suma de entrada1 y entrada2
    assign Branchtarget = entrada1 + entrada2;

endmodule