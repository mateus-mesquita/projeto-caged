# Teste para criação de conjunto de dados contagem
import pandas as pd
import sqlite3
from itertools import combinations, product
con_exc = sqlite3.connect('teste_py\cagedfor.db')
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

dados_comb = pd.DataFrame(combinacoes, columns=[
    "uf", "sexo", "raçacor", "faixa_idade", "graudeinstrução", "seção"
])


def contagem_total_admissoes(tabela, nome, conexao):
    contagem = pd.read_sql(
        f"SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%';", conexao)
    contagem = contagem.rename(columns={"count(*)": nome})
    valor = contagem.iloc[0, 0]

    dados = pd.DataFrame([{
        'uf': "",
        'sexo': "",
        'raçacor': "",
        'faixa_idade': "",
        'graudeinstrução': "",
        'seção': "",
        f"{nome}": valor
    }])
    return dados


def contagem_total_demissoes(tabela, nome, conexao):
    contagem = pd.read_sql(
        f"SELECT count(*) FROM {tabela} WHERE tipomovimentação NOT LIKE '%Admissao%';", conexao)

    valor = contagem.iloc[0, 0]

    dados = pd.DataFrame([{
        'uf': "",
        'sexo': "",
        'raçacor': "",
        'faixa_idade': "",
        'graudeinstrução': "",
        'seção': "",
        f"{nome}": valor
    }])
    return dados


def tabela_movimentacoes_demissoes(coluna, tabela, conexao, nome):
    dados_admissoes = pd.read_sql(
        f"SELECT * FROM {tabela} WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf in ('CE','PE','BA');", conexao)

    tabela = dados_admissoes.groupby(
        coluna)['tipomovimentação'].count().reset_index(name=nome)
    colunas = {
        0: "uf",
        1: "sexo",
        2: "raçacor",
        3: "faixa_idade",
        4: "graudeinstrução",
        5: "seção"
    }

    for val, col in colunas.items():
        if col not in tabela:
            tabela.insert(val, col, "")

    return tabela


def tabela_movimentacoes_admissoes(coluna, tabela, conexao, nome):
    dados_admissoes = pd.read_sql(
        f"SELECT * FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%' AND uf in ('CE','PE','BA');", conexao)

    tabela = dados_admissoes.groupby(
        coluna)['tipomovimentação'].count().reset_index(name=nome)
    colunas = {
        0: "uf",
        1: "sexo",
        2: "raçacor",
        3: "faixa_idade",
        4: "graudeinstrução",
        5: "seção",
        6: nome
    }

    for val, col in colunas.items():
        if col not in tabela:
            tabela.insert(val, col, "")
    return tabela


def tabela_final_admissoes(tabela, nome, conexao):
    colunas = ["uf", "sexo", "raçacor",
               "faixa_idade", "graudeinstrução", "seção"]
    lista_ = []

    for i in range(1, 7):
        for j in combinations(colunas, i):
         lista_.append(j)


    admissoes_geral = contagem_total_admissoes(tabela, nome, conexao)
    dados_novos = admissoes_geral.copy()  # cria cópia para acumular

    for item in lista_:
        if not isinstance(item, tuple):
            temp = tabela_movimentacoes_admissoes(item, tabela, conexao, nome)
            dados_novos = pd.concat([dados_novos, temp], axis=0, ignore_index=True)
        else:
            temp = tabela_movimentacoes_admissoes(list(item), tabela, conexao, nome)
            dados_novos = pd.concat([dados_novos, temp], axis=0, ignore_index=True)

    return dados_novos


def tabela_final_demissoes(tabela, nome, conexao):
    colunas = ["uf", "sexo", "raçacor",
               "faixa_idade", "graudeinstrução", "seção"]
    lista_ = []

    for i in range(1, 7):
        for j in combinations(colunas, i):
         lista_.append(j)


    admissoes_geral = contagem_total_demissoes(tabela, nome, conexao)
    dados_novos = admissoes_geral.copy()  # cria cópia para acumular

    for item in lista_:
        if not isinstance(item, tuple):
            temp = tabela_movimentacoes_demissoes(item, tabela, conexao, nome)
            dados_novos = pd.concat([dados_novos, temp], axis=0, ignore_index=True)
        else:
            temp = tabela_movimentacoes_demissoes(list(item), tabela, conexao, nome)
            dados_novos = pd.concat([dados_novos, temp], axis=0, ignore_index=True)
            

    return dados_novos


def tabela_resultado(conexao, arquivos_admissoes, arquivos_demissoes):
    df_combinacoes = pd.DataFrame(combinacoes, columns=[
        "uf", "sexo", "raçacor", "faixa_idade", "graudeinstrução", "seção"
    ])

    df_final = df_combinacoes.copy()
    for chave, valor in arquivos_admissoes.items():
        arquivo = tabela_final_admissoes(valor, chave, conexao)
        df_mes = df_combinacoes.merge(arquivo, how='left', on=[
                                      "uf", "sexo", "raçacor", "faixa_idade", "graudeinstrução", "seção"])
        df_final[chave] = df_mes[chave].fillna(0).astype(int)
        print(f"coluna {chave} foi executada")

    df_final_alterado = df_final.copy()
    for chave, valor in arquivos_demissoes.items():
        arquivo = tabela_final_demissoes(valor, chave, conexao)
        df_mes = df_final.merge(arquivo, how='left', on=[
                                "uf", "sexo", "raçacor", "faixa_idade", "graudeinstrução", "seção"])
        df_final_alterado[chave] = df_mes[chave].fillna(0).astype(int)
        print(f"coluna {chave} foi executada")

    return df_final_alterado

dados_for_admissoes = {
    "admissoes_for202301": "cagedfor202301",
    "admissoes_for202302": "cagedfor202302",
    "admissoes_for202303": "cagedfor202303",
    "admissoes_for202304": "cagedfor202304",
    "admissoes_for202305": "cagedfor202305",
    "admissoes_for202306": "cagedfor202306",
    "admissoes_for202307": "cagedfor202307",
    "admissoes_for202308": "cagedfor202308",
    "admissoes_for202309": "cagedfor202309",
    "admissoes_for202310": "cagedfor202310",
    "admissoes_for202311": "cagedfor202311",
    "admissoes_for202312": "cagedfor202312"
}

dados_for_demissoes = {
    "demissoes_for202301": "cagedfor202301",
    "demissoes_for202302": "cagedfor202302",
    "demissoes_for202303": "cagedfor202303",
    "demissoes_for202304": "cagedfor202304",
    "demissoes_for202305": "cagedfor202305",
    "demissoes_for202306": "cagedfor202306",
    "demissoes_for202307": "cagedfor202307",
    "demissoes_for202308": "cagedfor202308",
    "demissoes_for202309": "cagedfor202309",
    "demissoes_for202310": "cagedfor202310",
    "demissoes_for202311": "cagedfor202311",
    "demissoes_for202312": "cagedfor202312"
}

dados = pd.read_sql("SELECT * FROM cagedfor202301 WHERE uf in ('CE','BA','PE');",con_exc)
print(dados.groupby(['uf','raçacor','faixa_idade'])['tipomovimentação'].count().reset_index(name='teste'))