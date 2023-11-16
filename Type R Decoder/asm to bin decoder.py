import textwrap

# Diccionarios para opcode y function. 
opcode = {'add': '000000', 'sub': '000000', 'and': '000000' , 'or': '000000', 'slt':'000000'} 
function = {'add': '100000', 'sub': '100010', 'and': '100100' , 'or': '100101', 'slt':'101010'}

with open('input.txt', 'r') as f: #Se abre el archivo 'input.txt' en modo 'r' (read) como f.
    instruccion = ""
    line = f.readline() # Se guarda en line linea por linea del archivo.
    while line:
        res = line.split() # Separa la linea cada espacio y lo guarda en el vector res.
        line = f.readline()
        
        # Se remueve '$' de los elementos 1 2 y 3 del vector res (los registros).
        res[2] = res[2].replace('$','') 
        
        res[3] = res[3].replace('$','')
        
        res[1] = res[1].replace('$','')

        shamt = "00000" # Por claridad se agregan los 5 ceros de shamt a una variable, es str para facilidad de concatenar.
        
        # Concatena el resultado del diccionario de opcode, los registros, shamt y el diccionario de function para generar una cadena de 32 caracteres y un salto de linea.
        instruccion  += opcode[res[0]] + bin(int(res[2])).replace('0b','').zfill(5) + bin(int(res[3])).replace('0b','').zfill(5) + bin(int(res[1])).replace('0b','').zfill(5) + shamt +  function[res[0]] + "\n"


dividido = textwrap.wrap(instruccion, width=8) # Se divide la cadena cada 8 caracteres y se guarda en un vector llamado 'dividido'.
truncado = '\n'.join(dividido) # Se une todos los elementos del vector con un salto de linea (\n) entre cada elemento, esta cadena se guarda como 'truncado'.

with open('output.txt', 'w') as f: # Abre el archivo 'output.txt' en modo w (write) como f.
    f.write(truncado) # Se escribe la candena 'truncado' en el archivo.