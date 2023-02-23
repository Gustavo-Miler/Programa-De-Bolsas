#Escreva uma função que recebe como parâmetro uma lista e retorna 3 listas: a lista recebida dividida em 3 partes iguais. 
#Teste sua implementação com a lista abaixo

#lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

def split(lista):
    tamanho = len(lista) // 3
    return [lista[i:i + tamanho] for i in range(0, len(lista), tamanho)]

print(split(lista)[0], split(lista)[1], split(lista)[2])