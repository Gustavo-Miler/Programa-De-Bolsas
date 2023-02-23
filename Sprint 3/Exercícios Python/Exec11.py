#Escreva um programa que lê o conteúdo do arquivo texto arquivo_texto.txt e imprime o seu conteúdo.

with open('arquivo_texto.txt') as arquivo:
    print(arquivo.read())