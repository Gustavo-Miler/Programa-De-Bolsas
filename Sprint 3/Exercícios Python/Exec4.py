#Escreva um código Python que imprime todos os números primos de 1 até 100.

for num in range(100):
    if num > 1:
        flag = True
        for i in range(2, num):
            if num % i == 0:
                flag = False
                break
        if flag:
            print(num)