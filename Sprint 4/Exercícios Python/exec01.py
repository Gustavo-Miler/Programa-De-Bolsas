with open('number.txt') as arquivo:
    linhas = arquivo.read().splitlines()
    lista = sorted(list(filter(lambda x: x%2==0, map(int, linhas))), reverse=True)
    maiores_pares = lista[0:5]
    print(maiores_pares)
    print(sum(maiores_pares))