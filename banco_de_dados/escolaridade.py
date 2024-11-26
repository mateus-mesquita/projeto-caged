import basedosdados as bd

id_project= "plucky-pointer-433718-n5" # id do projeto

# Retornando apenas para grau de instrução:
def instrucao_(grau_inst):

    tabela = f'''
    WITH dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = 'grau_instrucao_apos_2005'
        AND id_tabela = 'microdados_vinculos'
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = 'sexo'
        AND id_tabela = 'microdados_vinculos'
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = 'raca_cor'
        AND id_tabela = 'microdados_vinculos'
)
SELECT
    count(*)
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
     where ano = 2022
    and dicionario_grau_instrucao_apos_2005.descricao_grau_instrucao_apos_2005 = '{grau_inst}';
    '''
    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]

def instrucao_raca(grau_inst, raca):
    tabela = f'''
  WITH 
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = 'grau_instrucao_apos_2005'
        AND id_tabela = 'microdados_vinculos'
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = 'sexo'
        AND id_tabela = 'microdados_vinculos'
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = 'raca_cor'
        AND id_tabela = 'microdados_vinculos'
)
SELECT
    count(*)
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
     where ano = 2022
    and dicionario_raca_cor.descricao_raca_cor = '{raca}'
    and dicionario_grau_instrucao_apos_2005.descricao_grau_instrucao_apos_2005 = '{grau_inst}';
    '''
    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]