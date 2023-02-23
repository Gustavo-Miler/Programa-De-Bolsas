#Escreva um código Python que verifique se três números digitados pelo usuário são pares ou ímpares. 
#Para cada número, imprima o Par: ou Ímpar: e o número correspondente.

n = []
for i in range(3):
    n.append(input('Insira um número.'))

for i in range(3):
    if (int(n[i]) % 2 == 0):
        print("Par:", n[i])
    else:
        print("Ímpar:", n[i])