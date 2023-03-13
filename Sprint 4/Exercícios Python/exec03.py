from functools import reduce
def calcula_saldo(lancamentos) -> float:
    return reduce(lambda x, y: x + y, map(lambda x: x[0] if x[1] == 'C' else -x[0], lancamentos))