import textwrap

# Diccionarios para opcode y function. 
opcode = {'add' : '000000', # Type R
          'sub' : '000000', 
          'and' : '000000' , 
          'or' : '000000', 
          'slt' : '000000',
          'nop' : '00000000000000000000000000000000',
          'addi' : '001000', # Type I
          'andi' : '001100',
          'ori' : '001101',
          'slti' : '001010',
          'sw' : '101011',
          'lw' : '100011', 
          'beq' : '000100'} 
function = {'add': '100000', 'sub': '100010', 'and': '100100' , 'or': '100101', 'slt':'101010'}
type = {'000000' : 'r', '001000' : 'i',  '001100' : 'i',  '001101' : 'i',  '001010' : 'i',  '101011' : 'i',  '100011' : 'i',  '000100' : 'i'}

with open('input.txt', 'r') as f: #Se abre el archivo 'input.txt' en modo 'r' (read) como f.
    instruccion = ""
    line = f.readline() # Se guarda en line linea por linea del archivo.
    while line:
        res = line.split() # Separa la linea cada espacio y lo guarda en el vector res.
        line = f.readline()
        res[0] = res[0].lower()

        if len(opcode[res[0]]) == 32: # NOP
            instruccion += opcode[res[0]] + "\n"
        
        elif type[opcode[res[0]]] == "r": # Type R
            # Se remueve '$' de los elementos 1 2 y 3 del vector res (los registros).
            res[1] = res[1].replace('$','')
            
            res[2] = res[2].replace('$','') 
            
            res[3] = res[3].replace('$','')

            shamt = "00000" # Por claridad se agregan los 5 ceros de shamt a una variable, es str para facilidad de concatenar.
            
            # Concatena el resultado del diccionario de opcode, los registros, shamt y el diccionario de function para generar una cadena de 32 caracteres y un salto de linea.
            instruccion  += opcode[res[0]] + bin(int(res[2])).replace('0b','').zfill(5) + bin(int(res[3])).replace('0b','').zfill(5) + bin(int(res[1])).replace('0b','').zfill(5) + shamt +  function[res[0]] + "\n"

        elif type[opcode[res[0]]] == "i": # Type I
            res[1] = res[1].replace('$','')
            
            res[2] = res[2].replace('$','') 
            
            res[3] = res[3].replace('#','')

            instruccion  += opcode[res[0]] + bin(int(res[2])).replace('0b','').zfill(5) + bin(int(res[1])).replace('0b','').zfill(5) + bin(int(res[3])).replace('0b','').zfill(16) + "\n"


dividido = textwrap.wrap(instruccion, width=8) # Se divide la cadena cada 8 caracteres y se guarda en un vector llamado 'dividido'.
truncado = '\n'.join(dividido) # Se une todos los elementos del vector con un salto de linea (\n) entre cada elemento, esta cadena se guarda como 'truncado'.

with open('output.txt', 'w') as f: # Abre el archivo 'output.txt' en modo w (write) como f.
    f.write(truncado) # Se escribe la candena 'truncado' en el archivo.