#Implemente duas classes Pato e Pardal que herdem de uma classe Passaro a habilidade de voar e emitir som, porém, 
#tanto Pato quanto Pardal devem emitir sons diferentes (de maneira escrita) no console.

class Passaro:
    def __init__(self, nome):
        self.nome = nome;
    
    def voar(self):
        print("Voando...")
    
    def emitir_som(self):
        print(f'{self.nome} emitindo som...')

class Pato(Passaro):
    def __init__(self, nome):
        super().__init__(nome)
    def emitir_som(self):
        print(f'{self.nome} emitindo som...')
        print("Quack Quack")

class Pardal(Passaro):
    def __init__(self, nome):
        super().__init__(nome)
    def emitir_som(self):
        print(f'{self.nome} emitindo som...')
        print("Piu Piu")

pato = Pato("Pato")
pardal = Pardal("Pardal")

print(pato.nome)
pato.voar()
pato.emitir_som()

print(pardal.nome)
pardal.voar()
pardal.emitir_som()
