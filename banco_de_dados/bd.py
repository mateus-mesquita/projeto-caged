# Criando Banco de dados - Rais:
import pandas as pd

# listas de estados:
estados = ["",'CE','PE']

# listas de sexos:
sexo_lista = ["","Feminino", "Masculino", "Não informado"]

# listas de raças:
raca_lista = ["","Branca", "Preta", "Parda", "Amarela", "Indígena", 
                 "Não informada", "Não identificado" ] 

# listas de graus de instruções:
grau_de_instrucao = ["","ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6.A.9.FUND",
                         "FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",
                         "SUP.INCOMP", "SUP.COMP", "MESTRADO",
                         "DOUTORADO"]

dados = []

for estado in estados:

    for sexo in sexo_lista:

        for raca in raca_lista:

            for instrucao in grau_de_instrucao:

                lista.append({'estado':estado,
                            'sexo':sexo,
                            'raca':raca,
                            'grau de instrucao':instrucao,
                            'estoque':...
                }
                )

# Gerando o dataframe:
df = pd.DataFrame(lista)

# Convertendo dataframe para arquivo bd
df.to_sql('RAIS',con = banco)
