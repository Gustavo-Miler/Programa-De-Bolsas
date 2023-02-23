#Crie uma classe  Calculo  que contenha um método que aceita dois parâmetros, X e Y, e retorne a soma dos dois. 
#Nessa mesma classe, implemente um método de subtração, que aceita dois parâmetros, X e Y, 
#e retorne a subtração dos dois (resultados negativos são permitidos).

class Calculo:
    def somar(x, y):
        print(f'Somando: {x}+{y} = {x + y}')
    def subtrair(x, y):
        print(f'Subtraindo: {x}-{y} = {x - y}')

x = 4
y = 5

Calculo.somar(x, y)
Calculo.subtrair(x, y)