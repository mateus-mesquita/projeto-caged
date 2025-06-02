# Funções para tabela de estoque da rais
import pandas as pd
import sqlite3
from itertools import combinations, product

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
combinacoes = list(product(local, sexo, raca_cor,
                   idades, grau_de_instrucao, setores))


def contagem_total_estoque(conexao):
    contagem = pd.read_sql(f"SELECT count(*) FROM rais2023;", conexao)
    contagem = contagem.rename(columns={"count(*)": 'estoque'})
    valor = contagem.iloc[0, 0]

    dados = pd.DataFrame([{
        'uf': "",
        'sexo': "",
        'raçacor': "",
        'faixa_idade': "",
        'graudeinstrução': "",
        'seção': "",
        "estpque": valor
    }])
    return dados


def tabela_estoque(coluna, conexao):
    dados_admissoes = pd.read_sql(f"SELECT * FROM rais2023;", conexao)

    tabela = dados_admissoes.groupby(
        coluna)['tipomovimentação'].count().reset_index(name='estoque')
    colunas = {
        0: "uf",
        1: "sexo",
        2: "raçacor",
        3: "faixa_idade",
        4: "graudeinstrução",
        5: "seção",
        6: 'estoque'
    }

    for val, col in colunas.items():
        if col not in tabela:
            tabela.insert(val, col, "")
        else:
            print(f"A coluna {col} existe")
    return tabela


def tabela_final_estoque(conexao):
    colunas = ["uf", "sexo", "raçacor",
               "faixa_idade", "graudeinstrução", "seção"]
    lista_ = []

    for i in range(1, 7):
        for j in combinations(colunas, i):
            if len(j) == 1:
                lista_.append(j[0])
            else:
                lista_.append(j)

    admissoes_geral = contagem_total_estoque(conexao)
    dados_novos = admissoes_geral.copy()  # cria cópia para acumular

    for item in lista_:
        temp = tabela_estoque(item, conexao)
        dados_novos = pd.concat([dados_novos, temp], axis=0, ignore_index=True)

    return dados_novos

def filtro(dados,local_,sexo_,raca_,idade_,gdi_,setor_,coluna):
    contagem = dados[(dados['uf'] == local_) &
                            (dados['sexo'] == sexo_) &
                            (dados['raçacor'] == raca_) &
                            (dados['faixa_idade'] == idade_) &
                            (dados['graudeinstrução'] == gdi_) &
                            (dados['seção'] == setor_)
                        ][coluna]
    return contagem.iloc[0] if len(contagem) > 0 else 0