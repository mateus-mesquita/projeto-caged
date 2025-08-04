import pandas as pd
from tqdm import tqdm
from itertools import product
from funcoes import busca_linear, listar_dados, lista_de_combinacoes
from funcoes import local,sexo,raca_cor,grau_de_instrucao,idades,clt
import sqlite3

# Lista de variáveis (colunas) que serão usadas para as contagens.
variaveis = ['sigla_uf','sexo','raca_cor','faixa_etaria','grau_instrucao_apos_2005','clt']

def contagem_total_estoque(conexao, nome):
    # Esta função conta o número total de registros na tabela 'rais2023'.

    # Executa uma consulta SQL para obter a contagem total de linhas.
    contagem = pd.read_sql(f"SELECT count(*) FROM {nome};", conexao)

    # Renomeia a coluna resultante de 'count(*)' para 'estoque' para clareza.
    contagem = contagem.rename(columns={"count(*)": 'estoque'})

    # Extrai o valor numérico da contagem total.
    valor = contagem.iloc[0, 0]

    # Cria um novo DataFrame com as colunas de categorias e preenche 'estoque' com o valor total.
    # Isso padroniza a saída para ter a mesma estrutura dos outros DataFrames de contagem.
    dados = pd.DataFrame([{
        'sigla_uf': "",
        'sexo': "",
        'raca_cor': "",
        'faixa_etaria': "",
        'grau_instrucao_apos_2005': "",
        'clt':"",
        "estoque": valor
    }])

    # Retorna o DataFrame contendo a contagem total.
    return dados

def contar_por_grupo(conexao, tabela, variaveis):
    # Esta função conta ocorrências de combinações únicas de variáveis.

    # Converte a lista de variáveis em uma string para uso na consulta SQL.
    # Exemplo: ['UF', 'Sexo'] se torna "UF, Sexo".
    colunas = ", ".join(variaveis)

    # Constrói a consulta SQL para selecionar as variáveis e contar as ocorrências.
    # `GROUP BY` agrupa os resultados para obter a contagem por cada combinação.
    sql = f"""
        SELECT {colunas}, COUNT(*) as estoque
        FROM {tabela}
        GROUP BY {colunas}
    """

    # Executa a consulta e retorna o resultado como um DataFrame.
    return pd.read_sql(sql, conexao)

def Tabela_contagem_rais(caminho, nome) -> pd.DataFrame:
    # Cria uma conexão com o banco de dados SQLite.
    conexao = sqlite3.connect(caminho)
    # Define a ordem das colunas para o DataFrame final.
    colunas = ['sigla_uf','sexo','raca_cor','faixa_etaria','grau_instrucao_apos_2005','clt','estoque']
    # Define os estados que serão filtrados.
    ufs = ['CE','BA','PE']

    # Obtém a contagem total de registros como a linha inicial do DataFrame.
    DADOS = contagem_total_estoque(conexao, nome)

    # Itera de 1 a 6 para gerar combinações de variáveis de diferentes tamanhos.
    # `tqdm` mostra uma barra de progresso para o loop.
    for i in tqdm(range(1, 7), desc="Processando Tabela"):
        # Concatena o DataFrame atual com os resultados da contagem por grupo.
        # `lista_de_combinacoes(i)` provavelmente retorna todas as combinações de tamanho `i` das variáveis.
        DADOS = pd.concat([DADOS, contar_por_grupo(conexao, nome, lista_de_combinacoes(i))])

    # Reordena as colunas do DataFrame e filtra os dados para incluir apenas os estados definidos em `ufs`.
    return DADOS.reindex(columns=colunas).query("sigla_uf in @ufs")

def Tabela_estoque(df) -> pd.DataFrame:
    # A palavra-chave `global` é usada para referenciar variáveis definidas no escopo global.
    global local, sexo, raca_cor, idades, grau_de_instrucao, clt

    # `listar_dados` provavelmente processa o DataFrame de entrada para alguma estrutura de dados interna.
    lista = listar_dados(df)

    try:
        # Usa uma list comprehension para criar uma lista de dicionários.
        # `product` cria o produto cartesiano das listas, gerando todas as combinações possíveis.
        # `tqdm` exibe uma barra de progresso para a criação da tabela.
        dados = [
            {
                "uf": local_,
                "sexo": sexo_,
                "raca": raca_,
                "idade": idade_,
                "grau_de_instrucao": gdi_,
                "CLT": clt_,
                # `busca_linear` busca o estoque correspondente à combinação de variáveis na lista.
                "estoque": busca_linear(lista, local_, sexo_, raca_, idade_, gdi_, clt_)
            }
            for local_, sexo_, raca_, idade_, gdi_, clt_ in tqdm(product(local, sexo, raca_cor, idades, grau_de_instrucao, clt), desc="Processando Tabela de estoque rais:")
        ]
        # Converte a lista de dicionários em um DataFrame do pandas.
        return pd.DataFrame(dados)
    except Exception as e:
        # Captura e imprime qualquer erro que ocorra durante o processamento.
        print(f"Erro ao gerar a tabela de estoques: {e}")

    

        