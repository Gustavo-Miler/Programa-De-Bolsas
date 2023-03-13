with open('estudantes.csv') as arquivo:
    linhas = arquivo.read().splitlines()
    linhas.sort()
    for l in linhas:
        notas = sorted(map(int, l.split(',')[1:6]), reverse=True)[0:3]
        print(f"Nome: {l.split(',')[0]} Notas: {notas} Média: {round(sum(notas) / len(notas), 2)}")