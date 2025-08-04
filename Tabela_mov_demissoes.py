import pandas as pd
from itertools import product
from funcoes import lista_de_combinacoes,listar_dados, busca_linear
from funcoes import local, sexo, raca_cor, idades, grau_de_instrucao, clt
import sqlite3
from tqdm import tqdm

# Lista de variáveis (colunas) que serão utilizadas para as análises.
variaveis = ['uf', 'sexo', 'raçacor', 'faixa_idade', 'graudeinstrução', 'clt']

def contagem_total_admissoes(conexao, tabela):
    # Esta função conta o número total de registros de demissão em uma tabela.
    try:
        # Executa uma consulta SQL para contar as linhas onde 'tipomovimentação'
        # NÃO contém a string 'Admissao'.
        contagem = pd.read_sql(f"SELECT count(*) FROM {tabela} WHERE tipomovimentação NOT LIKE '%Admissao%';", conexao)

        # Renomeia a coluna resultante de 'count(*)' para 'demissoes' para maior clareza.
        contagem = contagem.rename(columns={"count(*)": 'demissoes'})

        # Extrai o valor numérico da contagem total, que está na primeira linha e primeira coluna do DataFrame.
        valor = contagem.iloc[0, 0]

        # Cria um DataFrame padronizado com colunas de categorias vazias
        # e preenche a coluna 'demissoes' com o valor da contagem total.
        dados = pd.DataFrame([{
            'uf': "",
            'sexo': "",
            'raçacor': "",
            'faixa_idade': "",
            'graudeinstrução': "",
            "clt": "",
            "demissoes": valor
        }])

        # Retorna o DataFrame contendo a contagem total de demissões.
        return dados
    except ValueError as v:
        # Lida com erros se a coluna esperada 'count(*)' não for encontrada.
        print(v)
        print("A coluna 'count(*)' não foi encontrada no DataFrame retornado pela consulta SQL.")
    except IndexError as i:
        # Lida com erros se o DataFrame retornado estiver vazio ou tiver formato inesperado.
        print(i)
        print("Não foi possível extrair o valor da contagem; o DataFrame está vazio ou não possui a dimensão esperada.")

def contar_por_grupo(conexao, tabela, variaveis):
    # Esta função conta ocorrências de demissões para combinações únicas de variáveis.
    try:
        # Converte a lista de variáveis em uma string formatada para a consulta SQL.
        colunas = ", ".join(variaveis)

        # Constrói a consulta SQL para selecionar as variáveis e contar as demissões por grupo.
        # A cláusula `WHERE` filtra os registros que não são de admissão.
        # `GROUP BY` agrupa os resultados para obter a contagem por cada combinação única de colunas.
        sql = f"""
            SELECT {colunas}, COUNT(*) as demissoes
            FROM {tabela}
            WHERE tipomovimentação NOT LIKE '%Admissao%'
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

def executar_tabela_contagem_demissoes(caminho, nome):
    conexao = sqlite3.connect(caminho)
    colunas = ['uf','sexo','raçacor','faixa_idade','graudeinstrução','clt','demissoes']
    
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

def Tabela_mov_demissoes(df) -> pd.DataFrame:
    # Esta função cria uma tabela completa de demissões, preenchendo todas as combinações de categorias.
    # `listar_dados` provavelmente transforma o DataFrame de entrada em uma lista de tuplas para busca.
    lista = listar_dados(df)
    try:
        # Usa uma list comprehension com `product` para iterar por todas as combinações possíveis de categorias.
        # `product` cria o produto cartesiano das listas de categorias.
        dados = [
            {
                "uf": local_.upper(),
                "sexo": sexo_.upper(),
                "raca": raca_.upper(),
                "idade": idade_.upper(),
                "grau_de_instrucao": gdi_.upper(),
                "clt": clt_.upper(),
                # `busca_linear` busca o valor de demissões correspondente a cada combinação na lista.
                "demissoes": busca_linear(lista, local_, sexo_, raca_, gdi_, idade_, clt_)
            }
            for local_, sexo_, raca_, idade_, gdi_, clt_ in tqdm(product(local, sexo, raca_cor, idades, grau_de_instrucao, clt), desc = "Executando tabela final:")
        ]
        # Converte a lista de dicionários em um DataFrame.
        return pd.DataFrame(dados)
    except Exception as e:
        # Captura e imprime qualquer erro que ocorra durante o processamento.
        print(f"Erro ao executar tabela de movimentações: {e}")

def execucao_geral_tabela_mov_demissoes(caminho, nome) -> pd.DataFrame:
    # Esta é a função principal que coordena o fluxo completo de processamento.
    # Chama `executar_tabela_contagem_demissoes` para gerar a tabela de contagens.
    df_inicial = executar_tabela_contagem_demissoes(caminho, nome)
    # Chama `Tabela_mov_demissoes` para criar a tabela final com todas as combinações de categorias.
    df_final = Tabela_mov_demissoes(df_inicial)
    # Retorna o DataFrame final.
    return df_final