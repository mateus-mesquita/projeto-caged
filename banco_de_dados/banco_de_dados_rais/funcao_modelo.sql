WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = 'faixa_etaria'
        AND id_tabela = 'microdados_vinculos'
),
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
),

filtragem AS (
SELECT
    dados.ano as ano,
    dados.sigla_uf AS sigla_uf,
    diretorio_cnae_2_subclasse.descricao_secao AS cnae_2_subclasse_descricao_secao,
    descricao_faixa_etaria AS faixa_etaria,
    descricao_grau_instrucao_apos_2005 AS grau_instrucao_apos_2005,
    descricao_sexo AS sexo,
    descricao_raca_cor AS raca_cor
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT id_municipio,nome  FROM `basedosdados.br_bd_diretorios_brasil.municipio`) AS diretorio_id_municipio
    ON dados.id_municipio = diretorio_id_municipio.id_municipio
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_faixa_etaria`
    ON dados.faixa_etaria = chave_faixa_etaria
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = '{ano}'
),
rais AS(
  SELECT *, CASE 
   -- 1 a 1
    WHEN sexo = '{sexo_}' THEN TRUE
    WHEN raca_cor = '{raca_}' THEN TRUE
    WHEN faixa_etaria = '{idade_}' THEN TRUE
    WHEN grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN sigla_uf = '{local_}' THEN TRUE
    WHEN cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE  
  
    -- 2 a 2
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE

    WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE

    WHEN faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN faixa_etaria = '{idade_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE

    WHEN grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE

    WHEN sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE


    -- 3 a 3
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE


  -- filtragem para 4 variáveis:
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE

    WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN sexo = '{sexo_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
    WHEN faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE


-- 5 a 5:
  WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' THEN TRUE
WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
WHEN sexo = '{sexo_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE
WHEN raca_cor = '{raca_}' AND faixa_etaria = '{idade_}' AND grau_instrucao_apos_2005 = '{instrucao_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao = '{setor_}' THEN TRUE


-- filtragem para 6 variáveis
WHEN sexo = '{sexo_}' AND raca_cor = '{raca_}' AND faixa_etaria '{idade_}' AND grau_instrucao_apos_2005 '{idade_}' AND sigla_uf = '{local_}' AND cnae_2_subclasse_descricao_secao ='{setor_}' THEN TRUE
)

