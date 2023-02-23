#Escreva uma função que recebe uma lista e retorna uma nova lista sem elementos duplicados. Utilize a lista a seguir para testar sua função.

#['abc', 'abc', 'abc', '123', 'abc', '123', '123']

def listar(lista):
    l = set(elemento for elemento in lista)
    return list(l)

a = ['abc', 'abc', 'abc', '123', 'abc', '123', '123']

b = listar(a)

print(b)