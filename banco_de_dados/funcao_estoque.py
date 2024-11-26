# Criando função que coleta os estoques de empregos no banco de dados:

# Importando bibliotecas necessárias:
import basedosdados as bd
import numpy as np

# importando os modulos das consultas na base de dados:

# módulo para todos os parâmetros
from todos import query, query_geral

# módulo para os generos
from generos import query_sexo,sexo_estado,sexo_estado_raca, sexo_raca, sexo_instrucao
from generos import sexo_raca_instrucao

# módulo para graus de instrução:
from escolaridade import instrucao_, instrucao_raca

# módulo para os estados:
from estados import query_estado, estado_raca, estado_instrucao, estado_intrucao_raca,estado_intrucao_sexo

# módulo para as consultas em relação a raça:
from raca import raca_

def estoque(uf,raca,sexo,grau_inst):

    # listas:
    estados = ['CE','PE'] # lista de estados

    sexo_lista = ["Feminino", "Masculino"] # sexo

    raca_lista = ["Branca", "Preta", "Parda", "Amarela", "Indígena","Não identificado" ] # Raças

    grau_de_instrucao = ["ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6.A.9.FUND",
                         "FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",
                         "SUP.INCOMP", "SUP.COMP", "MESTRADO",
                         "DOUTORADO"]

    # Consulta para todos em branco
    if uf == "" and raca == "" and sexo == "" and grau_inst == "":

        resultado_estoque = query()

        return resultado_estoque
    # Todos valores existem
    elif uf in estados and raca in raca_lista and sexo in sexo_lista and grau_inst in grau_de_instrucao:

        resultado_estoque = query_geral(sexo=sexo, raca=raca,uf=uf,grau_inst=grau_inst)
        return resultado_estoque

    #existe apenas o sexo:
    elif sexo in sexo_lista and raca == "" and uf == "" and grau_inst == "":

      resultado_estoque = query_sexo(sexo=sexo)
      return resultado_estoque

    # Existe apenas o sexo e o estado:
    elif sexo in sexo_lista and raca == "" and uf in estados and grau_inst == "":

      resultado_estoque = sexo_estado(sexo=sexo,uf=uf)
      return resultado_estoque

    # Existe apenas o sexo, estado e a raça:
    elif sexo in sexo_lista and raca in raca_lista and uf in estados and grau_inst == "":

      resultado_estoque = sexo_estado_raca(sexo=sexo,uf=uf,raca=raca)
      return resultado_estoque

    # Existe apenas o sexo e raça:
    elif sexo in sexo_lista and raca in raca_lista and uf == "" and grau_inst == "":

      resultado_estoque = sexo_raca(sexo=sexo,raca=raca)
      return resultado_estoque

    #Existe apenas o grau de instrução e o sexo:
    elif sexo in sexo_lista and raca == "" and uf == "" and grau_inst in grau_de_instrucao:

       resultado_estoque = sexo_instrucao(sexo=sexo,grau_inst=grau_inst)
       return resultado_estoque

    #Existe apenas raça, grau de instrução e sexo:
    elif sexo in sexo_lista and raca in raca_lista and uf == "" and grau_inst in grau_de_instrucao:

       resultado_estoque = sexo_raca_instrucao(sexo=sexo,grau_inst=grau_inst,raca=raca)
       return resultado_estoque

    # Existe apenas Grau de instrução:
    elif uf == "" and raca == "" and sexo == "" and grau_inst in grau_de_instrucao:

      resultado_estoque = instrucao_(grau_inst = grau_inst)
      return resultado_estoque

    # Existe apenas o Estado:
    elif uf in estados and raca == "" and sexo == "" and grau_inst == "":

      resultado_estoque = query_estado(uf = uf)
      return resultado_estoque

    # Existe apenas estado e raça:
    elif uf in estados and raca in raca_lista and sexo == "" and grau_inst == "":

      resultado_estoque = estado_raca(uf = uf,raca=raca)
      return resultado_estoque

    # Exsite apenas estado e grau de instrução:
    elif uf in estados and raca == "" and sexo == "" and grau_inst in grau_de_instrucao:

        resultado_estoque = estado_instrucao(uf = uf,grau_inst = grau_inst)
        return resultado_estoque


    # Existe grau de instrução, Raça e estado:
    elif uf in estados and raca in raca_lista and sexo == "" and grau_inst in grau_de_instrucao:

        resultado_estoque = estado_intrucao_raca(uf = uf,grau_inst = grau_inst, raca = raca)
        return resultado_estoque

    # Existe sexo, grau de instrução e estado:
    elif uf in estados and raca == "" and sexo in sexo_lista and grau_inst in grau_de_instrucao:

        resultado_estoque = estado_intrucao_sexo(uf = uf,grau_inst = grau_inst, sexo = sexo)
        return resultado_estoque

    # Existe apenas raça:
    elif uf == "" and raca in raca_lista and sexo == "" and grau_inst == "":

        resultado_estoque = raca_(raca = raca)
        return resultado_estoque

    # Existe Raça e grau de instrução:
    elif uf == "" and raca in raca_lista and sexo == "" and grau_inst in grau_de_instrucao:

        resultado_estoque = instrucao_raca(grau_inst = grau_inst,raca = raca)
        return resultado_estoque

    # Caso não tenha sido registrado um tipo de consulta
    # retornamos um valor Null
    else:
      return np.nan