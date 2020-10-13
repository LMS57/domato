data = open('./c.txt').readlines()


alphabet = {
        "<":"lt",
        ">":"gt",
        "=":"=",
        "-":'-',
        "+":"+",
        "-":"-",
        "~":"~",
        "!":"ex",
        "%":"%",
        "^":"^",
        "&":"&",
        "*":"*",
        "(":"(",
        ")":")",
        "[":"[",
        "]":"]",
        "{":"{",
        "}":"}",
        "[":"[",
        "]":"]",
        "|":"|",
        ";":";",
        ":":":",
        ",":",",
        ".":".",
        "?":"?",
        "/":"/",
        }

def item(y):
    if "'" in y:
        tmp = y.split("'")[1]
        test = 0
        for x in alphabet:
            if x in tmp:
                test = 1
        if test:
            final = ''
            for x in tmp:
                final += item(alphabet[x])
            return final
        else:
            return item(tmp)
    else:
        return "<"+y+">"
start = 0
current = ""
space = "<space>"
declared = []
referenced = []
for x in data:
    x = x.strip()

    if x == "":
        continue
    if '%%' == x:
        start = 1
        continue
    elif start != 1:
        continue

    if x == "test":
        break;
    x = x.split(' ')
    
    if len(x) == 1:#item declaration or end
        if x[0] == ';':
            current = ""
        else:
            current = x[0]
            declared.append(item(x[0]))
            print ""
    else:
        x = x[1:]
        tmp = item(current)+'\t=\t'
        for y in range(len(x)):
            referenced.append(item(x[y]))
            tmp += item(x[y])
            if y != len(x)-1 and "'" not in x[y+1] and "'" not in x[y]:
                tmp+=space

        print tmp                


referenced = set(referenced)
final = []
for x in referenced:
    if x not in declared:
        final.append(x)

print "" 

for x in final:
    tmp = x+'\t=\t'
    x = x[1:-1]
    print tmp + x.lower()
