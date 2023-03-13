def conta_vogais(texto:str)-> int:
    vogais = ['a','A','e','E','i','I','o','O','u','U']
    return len(list(filter(lambda x: x in vogais, texto)))