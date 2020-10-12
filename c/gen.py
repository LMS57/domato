data = open('./c.txt').readlines()


alphabet = {"<":"lt",">":"gt","=":"=",
        "-":'-',
        "+":"+",
        "-":"-",
        "~":"~",
        "!":"!",
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

for x in data:
    x = x.strip()
    if x == "":
        print ""
        continue
    if '\t|\t' in x:#if \t|\t exists this is not apart of the expression
        x = x.split('\t')
        for y in x[2:]:
            if y =='|':
                continue
            print '<'+x[0]+'>\t'+x[1]+'\t'+item(y)
    else:
        x = x.split('\t')
        tmp = '<'+x[0]+'>\t'+x[1]+'\t'
        for y in range(2,len(x)):
            tmp+=item(x[y])
            if y < len(x)-1:
                tmp+="<space>"
        print tmp 

