import pandas as pd
from itertools import product
from funcoes import lista_de_combinacoes, listar_dados, busca_linear
from funcoes import local, sexo, raca_cor, idades, grau_de_instrucao, clt
import sqlite3
from tqdm import tqdm

# Lista de variáveis (colunas) que serão utilizadas para as análises.
variaveis = ['uf', 'sexo', 'raçacor', 'faixa_idade', 'graudeinstrução', 'clt']

def contagem_total_admissoes(conexao, tabela):
    # Esta função conta o número total de registros de admissão em uma tabela.
    try:
        # Executa uma consulta SQL para contar as linhas onde 'tipomovimentação'
        # contém a string 'Admissao'.
        contagem = pd.read_sql(f"SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%';", conexao)

        # Renomeia a coluna resultante de 'count(*)' para 'admissoes' para maior clareza.
        contagem = contagem.rename(columns={"count(*)": 'admissoes'})

        # Extrai o valor numérico da contagem total.
        valor = contagem.iloc[0, 0]

        # Cria um DataFrame padronizado com colunas de categorias vazias
        # e preenche a coluna 'admissoes' com o valor da contagem total.
        dados = pd.DataFrame([{
            'uf': "",
            'sexo': "",
            'raçacor': "",
            'faixa_idade': "",
            'graudeinstrução': "",
            "clt": "",
            "admissoes": valor
        }])

        # Retorna o DataFrame contendo a contagem total.
        return dados
    except ValueError as v:
        # Lida com erros se a coluna esperada 'count(*)' não for encontrada.
        print(v)
        print("A coluna 'count(*)' não foi encontrada no DataFrame retornado pela consulta SQL.")
    except IndexError as i:
        # Lida com erros se o DataFrame retornado estiver vazio.
        print(i)
        print("Não foi possível extrair o valor da contagem; o DataFrame está vazio ou não possui a dimensão esperada.")

def contar_por_grupo(conexao, tabela, variaveis):
    # Esta função conta ocorrências de combinações únicas de variáveis.
    try:
        # Converte a lista de variáveis em uma string para uso em consultas SQL.
        colunas = ", ".join(variaveis)

        # Constrói a consulta SQL para selecionar as variáveis e contar as admissões por grupo.
        # A cláusula `WHERE` filtra apenas os registros de admissão.
        # `GROUP BY` agrupa os resultados para obter a contagem por cada combinação.
        sql = f"""
            SELECT {colunas}, COUNT(*) as admissoes
            FROM {tabela}
            WHERE tipomovimentação LIKE '%Admissao%'
            GROUP BY {colunas}
        """
        # Executa a consulta e retorna o resultado como um DataFrame do pandas.
        return pd.read_sql(sql, conexao)
    except TypeError as t:
        # Lida com erros se o tipo de `variaveis` for incorreto.
        print(t)
        print("As variáveis devem ser uma lista ou tupla de strings.")
    except pd.io.sql.DatabaseError as pdr:
        # Lida com erros relacionados à execução da consulta SQL.
        print(pdr)
        print("Falha ao executar a consulta SQL. Verifique a conexão com o banco de dados e a sintaxe da query.")
    except AttributeError as a:
        # Lida com erros se o objeto de conexão for inválido.
        print(a)
        print("O objeto 'conexao' não é um objeto de conexão de banco de dados válido para pandas.")


def executar_tabela_contagem(caminho, nome):
    conexao = sqlite3.connect(caminho)
    colunas = ['uf','sexo','raçacor','faixa_idade','graudeinstrução','clt','admissoes']
    
    comb1 = lista_de_combinacoes(1)
    comb2 = lista_de_combinacoes(2)
    comb3 = lista_de_combinacoes(3)
    comb4 = lista_de_combinacoes(4)
    comb5 = lista_de_combinacoes(5)
    comb6 = lista_de_combinacoes(6)
    
    # Linha Inial(contagem Total)
    DADOS = contagem_total_admissoes(conexao,nome) # Obtém contagem total inicial.
    
    for comb1_ in tqdm(comb1): # Itera sobre a combinação 1.
        DADOS = pd.concat([DADOS,contar_por_grupo(conexao,nome,comb1_)]) # Concatena dados do grupo.
    
    for comb2_ in tqdm(comb2):
        DADOS = pd.concat([DADOS,contar_por_grupo(conexao,nome,comb2_)])
    
    for comb3_ in tqdm(comb3):
        DADOS = pd.concat([DADOS, contar_por_grupo(conexao,nome,comb3_)])
    
    for comb4_ in tqdm(comb4):
        DADOS = pd.concat([DADOS,contar_por_grupo(conexao,nome,comb4_)])
    
    for comb5_ in tqdm(comb5):
        DADOS = pd.concat([DADOS,contar_por_grupo(conexao,nome,comb5_)])
    
    for comb6_ in tqdm(comb6):
        DADOS = pd.concat([DADOS,contar_por_grupo(conexao,nome,comb6_)])
        
    return DADOS.reindex(columns = colunas).query("uf in @local").fillna("") # Reordena colunas e retorna DataFrame.

def Tabela_mov_admissoes(df) -> pd.DataFrame:
    # `listar_dados` provavelmente processa o DataFrame de entrada para alguma estrutura de dados.
    lista = listar_dados(df)
    try:
        # Utiliza uma list comprehension com `product` para criar todas as combinações possíveis
        # das variáveis, gerando uma tabela completa de movimentações.
        dados = [
            {
                "uf": local_.upper(),
                "sexo": sexo_.upper(),
                "raca": raca_.upper(),
                "idade": idade_.upper(),
                "grau_de_instrucao": gdi_.upper(),
                "clt": clt_.upper(),
                # `busca_linear` encontra o valor de admissões correspondente à combinação de variáveis.
                "admissoes": busca_linear(lista, local_, sexo_, raca_, idade_,gdi_, clt_)
            }
            # `product` cria o produto cartesiano das listas de categorias, iterando por todas as combinações.
            for local_, sexo_, raca_, idade_, gdi_, clt_ in tqdm(product(local, sexo, raca_cor, idades, grau_de_instrucao, clt))
        ]
        # Converte a lista de dicionários em um DataFrame.
        return pd.DataFrame(dados)
    except Exception as e:
        # Captura e imprime qualquer erro que ocorra durante o processamento.
        print(f"Erro ao executar tabela de movimentações: {e}")

def execucao_geral_tabela_mov(caminho, nome) -> pd.DataFrame:
    # Executa a função para criar o DataFrame de contagens por grupo.
    df_inicial = executar_tabela_contagem(caminho, nome)
    # Executa a função para criar a tabela final de movimentações a partir do DataFrame inicial.
    df_final = Tabela_mov_admissoes(df_inicial)
    # Retorna o DataFrame final.
    return df_final




        
    
    