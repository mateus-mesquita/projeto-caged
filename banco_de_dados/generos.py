# Consultas relacionadas aos estados:
import basedosdados as bd

id_project= "plucky-pointer-433718-n5" # id do projeto

'''
Parâmetros das funções:

1) - estado
2) - sexo
3) - grau de intrução
4) - raça
'''
id_project= "plucky-pointer-433718-n5" # id do projeto
# Consulta que retorna se apenas o estado existir na tabela
def query_sexo(sexo):

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
    and dicionario_sexo.descricao_sexo = '{sexo}';
    '''
    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]


# Consulta qe retorna para sexo e e estado:

def sexo_estado(sexo,uf):

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
    and diretorio_sigla_uf.sigla = '{uf}'
    and dicionario_sexo.descricao_sexo = '{sexo}';
    '''

    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]

# Tabela que retorna para sexo, uf e raça:
def sexo_estado_raca(sexo,uf,raca):

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
    and diretorio_sigla_uf.sigla = '{uf}'
    and dicionario_raca_cor.descricao_raca_cor = '{raca}'
    and dicionario_sexo.descricao_sexo = '{sexo}';
    '''

    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]

# Consulta que retorna apenas para sexo e raça:
def sexo_raca(sexo,raca):

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
    and dicionario_sexo.descricao_sexo = '{sexo}';
    '''

    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]

# Consulta que retorna para sexo e grau de instrução:
def sexo_instrucao(sexo,grau_inst):

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
    and dicionario_sexo.descricao_sexo = '{sexo}'
    and dicionario_grau_instrucao_apos_2005.descricao_grau_instrucao_apos_2005 = '{grau_inst}';
    '''

    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]

# Sexo, raça e grau de instrução:
def sexo_raca_instrucao(sexo,raca,grau_inst):

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
    and dicionario_sexo.descricao_sexo ='{sexo}'
    and dicionario_grau_instrucao_apos_2005.descricao_grau_instrucao_apos_2005 = '{grau_inst}';
    '''

    resultado = bd.read_sql(tabela,billing_project_id = id_project)
    return resultado.iloc[0,0]