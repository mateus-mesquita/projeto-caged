import pandas as pd
from itertools import product
from funcoes import lista_de_combinacoes, busca_linear_compt,construir_dict_compt, compts
from funcoes import local,sexo,raca_cor,idades,grau_de_instrucao,clt,dic_meses24
from joblib import Parallel, delayed # Importa Parallel para execução paralela e delayed para atrasar a execução de funções
from joblib.parallel import parallel_backend # Importa parallel_backend para gerenciar o backend de paralelização
import sqlite3
from tqdm import tqdm

variaveis = ['competênciamov','uf','sexo','raçacor','faixa_idade','graudeinstrução','clt']

def contagem_total_admissoes(conexao,tabela):
    # Esta função conta o número total de registros na tabela.
  try:
    contagem = pd.read_sql(f"SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%';", conexao) # Conta total de admissões.

    contagem = contagem.rename(columns={"count(*)": 'admissoes'}) # Renomeia coluna.

    valor = contagem.iloc[0, 0] # Extrai o valor da contagem.

    dados = pd.DataFrame([{
        'competênciamov':"",
        'uf': "",
        'sexo': "",
        'raçacor': "",
        'faixa_idade': "",
        'graudeinstrução': "",
        "clt": "",
        "admissoes": valor
    }]) # Cria DataFrame padronizado.

    return dados # Retorna o DataFrame.
  except ValueError as v:
    print(v)
    print( "A coluna 'count(*)' não foi encontrada no DataFrame retornado pela consulta SQL.")
  except IndexError as i:
    print(i)
    print("Não foi possível extrair o valor da contagem; o DataFrame está vazio ou não possui a dimensão esperada.")

def contar_por_grupo(conexao, tabela, variaveis):
    # Esta função conta ocorrências únicas de combinações de variáveis.
    try:
        colunas = ", ".join(variaveis)  # Formata variáveis para SQL.

        sql = f"""
            SELECT {colunas}, COUNT(*) as admissoes
            FROM {tabela}
            WHERE tipomovimentação LIKE '%Admissao%'
            GROUP BY {colunas}
        """  # Constrói a consulta SQL de contagem.
        return pd.read_sql(sql, conexao)  # Executa a consulta e retorna DataFrame.
    except TypeError as t:
        print(t)
        print("As variáveis devem ser uma lista ou tupla de strings.")
    except pd.io.sql.DatabaseError as pdr:
        print(pdr)
        print("Falha ao executar a consulta SQL. Verifique a conexão com o banco de dados e a sintaxe da query.")
    except AttributeError as a:
        print(a)
        print("O objeto 'conexao' não é um objeto de conexão de banco de dados válido para pandas.")
        
def executar_tabela_contagem(conexao, nome):
    con = sqlite3.connect(conexao)
    colunas = ['competênciamov','uf','sexo','raçacor','faixa_idade','graudeinstrução','clt','admissoes']
    
    teste = []
    for n in range(1, 8):  # de 1 a 7
        combs = lista_de_combinacoes(n, True)
        for comb_ in combs:
            teste.append(contar_por_grupo(con, nome, comb_))
    
    DADOS = pd.concat(teste, ignore_index=True)
    return DADOS.reindex(columns=colunas).fillna("")

def executar_linha_mov_admissao(df,lista,local_,sexo_,raca_,idade_,gdi_,clt_) -> dict:
    global dic_meses24
    lista_compt= compts(df)

    dic_linha = {
        "uf":local_,
        "sexo":sexo_,
        "raca":raca_,
        "idade":idade_,
        "grau_de_instrucao":gdi_,
        "clt":clt_,
        "janeiro":0,
        "fevereiro":0,
        "março":0,
        "abril":0,
        "maio":0,
        "junho":0,
        "julho":0,
        "agosto":0,
        "setembro":0,
        "outubro":0,
        "novembro":0,
        "dezembro":0
    }
    lista_menor = [menor for menor in lista_compt if menor == "" or menor <= 202401.0]
    lista_maior = [maior for maior in lista_compt if maior != "" and maior > 202401.0]
    
    for i in lista_menor:
        for mes in dic_meses24[202401.0]:
            dic_linha[mes] += busca_linear_compt(lista,i,local_,sexo_,raca_,idade_,gdi_,clt_)
    
    for maior in lista_maior:
        for mes_ in dic_meses24[maior]:
            dic_linha[mes_] += busca_linear_compt(lista,mes_,local_,sexo_,raca_,idade_,gdi_,clt_)

    return dic_linha

def executar_tabela_compt_admissao(df):
    global local,sexo,raca_cor,idades,grau_de_instrucao,clt
    
    dic_dados = construir_dict_compt(df)
    with parallel_backend('loky'): # Usa o backend 'loky' para paralelização
        resultados = Parallel(n_jobs=-1, verbose=5)( # Inicia a execução paralela
                delayed(executar_linha_mov_admissao)(df,dic_dados,local_, sexo_, raca_, idade_, gdi_, clt_) # Chama criar_df_for_demissoes em paralelo
                for local_, sexo_, raca_, idade_, gdi_, clt_ in product(local,sexo,raca_cor,idades,grau_de_instrucao,clt)
            )
    return pd.DataFrame(resultados) # Retorna um DataFrame com os resultados

def Tabela_comptmov_admissao(caminho,nome) -> pd.DataFrame:
    df = executar_tabela_contagem(caminho,nome)
    tabela_final = executar_tabela_compt_admissao(df)
    return tabela_final

