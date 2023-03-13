def calcular_valor_maximo(operadores,operandos) -> float:
    return max(map(lambda x: eval(str(x[1][0]) + x[0] + str(x[1][1])), zip(operadores, operandos)))