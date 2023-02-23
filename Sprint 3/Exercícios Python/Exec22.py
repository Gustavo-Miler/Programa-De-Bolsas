#Crie uma classe chamada "Pessoa" com um atributo privado "nome" (representado como "__nome") e um atributo público "id". 
#Adicione duas funções à classe, uma para definir o valor de "nome" e outra para obter o valor de "nome". 
#Observe que o atributo "nome" deve ser privado e acessado somente através dessas funções.

class Pessoa:
    def __init__(self, id):
        self.id = id;
        self.__nome = 'Sem Nome'
    
    @property
    def nome(self):
        return self.__nome
    
    @nome.setter
    def nome(self, valor):
        self.__nome = valor

pessoa = Pessoa(0)
pessoa.nome = "Fulano de tal"
print(pessoa.nome)