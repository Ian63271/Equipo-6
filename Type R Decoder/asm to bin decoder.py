import textwrap

opcode = {'add': '000000', 'sub': '000000', 'and': '000000' , 'or': '000000', 'slt':'000000'}
function = {'add': '100000', 'sub': '100010', 'and': '100100' , 'or': '100101', 'slt':'101010'}

with open('input.txt', 'r') as f:
    instruccion = ""
    line = f.readline()
    while line:
        res = line.split()
        line = f.readline()
        
        res[2] = res[2].replace('$','')
        
        res[3] = res[3].replace('$','')
        
        res[1] = res[1].replace('$','')

        shamt = "00000"
        
        instruccion  += opcode[res[0]] + bin(int(res[2])).replace('0b','').zfill(5) + bin(int(res[3])).replace('0b','').zfill(5) + bin(int(res[1])).replace('0b','').zfill(5) + shamt +  function[res[0]] + "\n"


dividido = textwrap.wrap(instruccion, width=8)
truncado = '\n'.join(dividido)

with open('output.txt', 'w') as f:
    f.write(truncado)

print(instruccion)