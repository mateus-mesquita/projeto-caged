# Teste para criação de conjunto de dados contagem
import pandas as pd
import sqlite3
from itertools import combinations
import re

conexao = sqlite3.connect("teste_py\cagedexc.db") # conexão com banco de dados

def tabela_movimentacoes(coluna, tabela,conexao,nome):
    dados_admissoes = pd.read_sql(f"SELECT * FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%' AND uf in ('CE','PE','BA');",conexao)
    
    tabela = dados_admissoes.groupby(coluna)['tipomovimentação'].count().reset_index(name=nome)
    colunas = {
        0:"uf",
        1:"sexo",
        2:"raçacor",
        3:"faixa_idade",
        4:"graudeinstrução",
        5:"seção"
    }
    
    for val,col in colunas.items():
        if col not in tabela:
            tabela.insert(val,col,"")
        else:
            print(f"A coluna {col} existe")
    return tabela

def tabela_final(tabela,nome):
    colunas = ["uf", "sexo", "raçacor", "faixa_idade", "graudeinstrução", "seção"]
    lista_ = []

    for i in range(1,7):
        for j in combinations(colunas,i):
            if len(j) == 1:
                lista_.append(j[0])
            else:
                lista_.append(j[0])

    dados_teste = tabela_movimentacoes('uf',tabela,conexao,nome)
    dados_novos = dados_teste.copy()  # cria cópia para acumular

    for item in lista_:
            temp = tabela_movimentacoes(item,tabela,conexao,nome)
            dados_novos = pd.concat([dados_novos, temp], axis=0, ignore_index=True)

    return dados_novos

import pandas as pd
from itertools import product

# Vetores
local = ["", "CE", "PE", "BA"]
sexo = ["", "Feminino", "Masculino", "Não informado"]
raca_cor = ["", "Branca", "Preta", "Parda", "Amarela", "Indígena", 
            "Não informada", "Não identificada"]
grau_de_instrucao = ["", "ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6.A.9.FUND",
                     "FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",
                     "SUP.INCOMP", "SUP.COMP", "MESTRADO", "DOUTORADO"]
setores = ["",
           "Agricultura, Pecuária, Produção Florestal, Pesca e Aquicultura",
           "Indústrias Extrativas",
           "Indústrias de Transformação",
           "Eletricidade e Gás",
           "Água, Esgoto, Atividades de Gestão de Resíduos e Descontaminação",
           "Construção",
           "Comércio; Reparação de Veículos Automotores e Motocicletas",
           "Transporte, Armazenagem e Correio",
           "Alojamento e Alimentação",
           "Informação e Comunicação",
           "Atividades Financeiras, de Seguros e Serviços Relacionados",
           "Atividades Imobiliárias",
           "Atividades Profissionais, Científicas e Técnicas",
           "Atividades Administrativas e Serviços Complementares",
           "Administração Pública, Defesa e Seguridade Social",
           "Educação",
           "Saúde Humana e Serviços Sociais",
           "Artes, Cultura, Esporte e Recreação",
           "Outras Atividades de Serviços",
           "Serviços Domésticos",
           "Organismos Internacionais e Outras Instituições Extraterritoriais",
           "Não identificado"]
idades = ["", "14 a 17", "18 a 24", "25 a 39", "40 a 59", "60 ou mais"]

# Geração do DataFrame com todas as combinações
combinacoes = list(product(local, sexo, raca_cor, idades ,grau_de_instrucao,setores))

def tabela_final_concat():
    df_combinacoes = pd.DataFrame(combinacoes, columns=[
        "uf", "sexo", "raçacor", "faixa_idade","graudeinstrução", "seção"
    ])

    tabelas = {
    "admissoes_exc202301": "cagedexc202301",
    "admissoes_exc202302": "cagedexc202302",
    "admissoes_exc202303": "cagedexc202303",
    "admissoes_exc202304": "cagedexc202304",
    "admissoes_exc202305": "cagedexc202305",
    "admissoes_exc202306": "cagedexc202306",
    "admissoes_exc202307": "cagedexc202307",
    "admissoes_exc202308": "cagedexc202308",
    "admissoes_exc202309": "cagedexc202309",
    "admissoes_exc202310": "cagedexc202310",
    "admissoes_exc202311": "cagedexc202311",
    "admissoes_exc202312": "cagedexc202312"
}   
    df_final = df_combinacoes.copy()
    for chave, valor in tabelas.items():
        arquivo = tabela_final(valor,chave)
        df_mes = df_combinacoes.merge(arquivo,how='left',on=["uf", "sexo", "raçacor", "faixa_idade","graudeinstrução", "seção"])
        df_final[chave] = df_mes[chave].fillna(0).astype(int)
        
    return df_final



