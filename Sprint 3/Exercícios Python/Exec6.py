#Escreva um programa que retorne o que ambas as listas têm em comum (sem repetições). 
#O seu programa deve funcionar para listas de qualquer tamanho.

a = [1, 1, 2, 3, 5, 8, 14, 21, 34, 55, 89]
b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

c = list(set(num for num in a if num in b))
print(c)