#Verifique se cada uma das palavras da lista ['maça', 'arara', 'audio', 'radio', 'radar', 'moto'] é ou não um palíndromo.

#Obs: Palíndromo é uma palavra que permanece igual se lida de traz pra frente.

lista = ['maça', 'arara', 'audio', 'radio', 'radar', 'moto']

for i in lista:
    if i == i[::-1]:
        print("A palavra:", i, "é um palíndromo")
    else:
        print("A palavra:", i, "não é um palíndromo")