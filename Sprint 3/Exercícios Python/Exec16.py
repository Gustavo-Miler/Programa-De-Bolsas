#Escreva uma função que recebe uma string de números separados por vírgula e retorne a soma de todos eles. 
#Depois imprima a soma dos valores.

#A string deve ter valor  "1,3,4,6,10,76"

def soma(x):
    return sum([int(i) for i in x.split(",")])

print(soma("1,3,4,6,10,76"))
        