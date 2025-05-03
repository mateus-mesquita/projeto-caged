# testando consultas na base dos dados da Rais
library(basedosdados)
library(bigrquery)



funcao_estoque.1 <- function(ano,local_,sexo_,raca_,idade_,instrucao_,setor_){
  
  # Defina o seu projeto no Google Cloud
  set_billing_id("plucky-pointer-433718-n5")
  
  query <- glue('
WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "faixa_etaria"
        AND id_tabela = "microdados_vinculos"
),
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "grau_instrucao_apos_2005"
        AND id_tabela = "microdados_vinculos"
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "sexo"
        AND id_tabela = "microdados_vinculos"
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "raca_cor"
        AND id_tabela = "microdados_vinculos"
),

filtragem AS (
SELECT
    dados.sigla_uf AS sigla_uf,
    diretorio_cnae_2_subclasse.descricao_secao AS cnae_2_subclasse_descricao_secao,
    descricao_grau_instrucao_apos_2005 AS grau_instrucao_apos_2005,
    descricao_sexo AS sexo,
    descricao_raca_cor AS raca_cor,
      CASE 
        WHEN idade >= 14 AND idade <= 17 THEN "14 a 17 anos"
        WHEN idade >= 18 AND idade <= 24 THEN "18 a 24 anos"
        WHEN idade >= 25 AND idade <= 39 THEN "25 a 39 anos"
        WHEN idade >= 40 AND idade <= 59 THEN "40 a 59 anos"
        WHEN idade >= 60 THEN "60 anos ou mais"
        ELSE NULL
      END AS faixa_etaria
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = {ano}
),
rais AS (
  SELECT *, CASE 
    -- 1 a 1
    WHEN sexo = "{sexo_}" THEN TRUE
    WHEN raca_cor = "{raca_}" THEN TRUE
    WHEN faixa_etaria = "{idade_}" THEN TRUE
    WHEN grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN sigla_uf = "{local_}" THEN TRUE
    WHEN cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE  
    ELSE FALSE

  END AS validacao
  FROM filtragem
)

SELECT count(*) FROM rais WHERE validacao = TRUE;


')
  
  s = read_sql(query, billing_project_id = get_billing_id())
  return(s$f0_[1])
}

funcao_estoque.2 <- function(ano,local_,sexo_,raca_,idade_,instrucao_,setor_){
  set_billing_id("plucky-pointer-433718-n5")
  
  query <- glue('
WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "faixa_etaria"
        AND id_tabela = "microdados_vinculos"
),
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "grau_instrucao_apos_2005"
        AND id_tabela = "microdados_vinculos"
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "sexo"
        AND id_tabela = "microdados_vinculos"
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "raca_cor"
        AND id_tabela = "microdados_vinculos"
),

filtragem AS (
SELECT
    dados.sigla_uf AS sigla_uf,
    diretorio_cnae_2_subclasse.descricao_secao AS cnae_2_subclasse_descricao_secao,
    descricao_grau_instrucao_apos_2005 AS grau_instrucao_apos_2005,
    descricao_sexo AS sexo,
    descricao_raca_cor AS raca_cor,
      CASE 
        WHEN idade >= 14 AND idade <= 17 THEN "14 a 17 anos"
        WHEN idade >= 18 AND idade <= 24 THEN "18 a 24 anos"
        WHEN idade >= 25 AND idade <= 39 THEN "25 a 39 anos"
        WHEN idade >= 40 AND idade <= 59 THEN "40 a 59 anos"
        WHEN idade >= 60 THEN "60 anos ou mais"
        ELSE NULL
      END AS faixa_etaria
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = {ano}
),
rais AS (
  SELECT *, CASE 
    -- 2 a 2
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE

    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE

    WHEN faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN faixa_etaria = "{idade_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE

    WHEN grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE

    WHEN sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    ELSE FALSE

  END AS validacao
  FROM filtragem
)

SELECT count(*) FROM rais WHERE validacao = TRUE;

')

s = read_sql(query, billing_project_id = get_billing_id())
return(s$f0_[1])
}

funcao_estoque.3 <- function(ano,local_,sexo_,raca_,idade_,instrucao_,setor_){
  set_billing_id("plucky-pointer-433718-n5")
  
  query <- glue('
WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "faixa_etaria"
        AND id_tabela = "microdados_vinculos"
),
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "grau_instrucao_apos_2005"
        AND id_tabela = "microdados_vinculos"
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "sexo"
        AND id_tabela = "microdados_vinculos"
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "raca_cor"
        AND id_tabela = "microdados_vinculos"
),

filtragem AS (
SELECT
    dados.sigla_uf AS sigla_uf,
    diretorio_cnae_2_subclasse.descricao_secao AS cnae_2_subclasse_descricao_secao,
    descricao_grau_instrucao_apos_2005 AS grau_instrucao_apos_2005,
    descricao_sexo AS sexo,
    descricao_raca_cor AS raca_cor,
      CASE 
        WHEN idade >= 14 AND idade <= 17 THEN "14 a 17 anos"
        WHEN idade >= 18 AND idade <= 24 THEN "18 a 24 anos"
        WHEN idade >= 25 AND idade <= 39 THEN "25 a 39 anos"
        WHEN idade >= 40 AND idade <= 59 THEN "40 a 59 anos"
        WHEN idade >= 60 THEN "60 anos ou mais"
        ELSE NULL
      END AS faixa_etaria
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = {ano}
),
rais AS (
  SELECT *, CASE 
    -- 3 a 3
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    ELSE FALSE

  END AS validacao
  FROM filtragem
)

SELECT count(*) FROM rais WHERE validacao = TRUE;


')

s = read_sql(query, billing_project_id = get_billing_id())
return(s$f0_[1])
}

contagem_arquivo <- function(ano){
  # Defina o seu projeto no Google Cloud
  set_billing_id("utility-emblem-409417")
  
  query <- glue('
WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "faixa_etaria"
        AND id_tabela = "microdados_vinculos"
),
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "grau_instrucao_apos_2005"
        AND id_tabela = "microdados_vinculos"
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "sexo"
        AND id_tabela = "microdados_vinculos"
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "raca_cor"
        AND id_tabela = "microdados_vinculos"
)

SELECT
    count(*)
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = {ano};')
  s = read_sql(query, billing_project_id = get_billing_id())
  return(s$f0_[1])
  
}

funcao_estoque.4 <- function(ano,local_,sexo_,raca_,idade_,instrucao_,setor_){
  
  set_billing_id("utility-emblem-409417")
  query <- glue('
WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "faixa_etaria"
        AND id_tabela = "microdados_vinculos"
),
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "grau_instrucao_apos_2005"
        AND id_tabela = "microdados_vinculos"
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "sexo"
        AND id_tabela = "microdados_vinculos"
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "raca_cor"
        AND id_tabela = "microdados_vinculos"
),

filtragem AS (
SELECT
    dados.sigla_uf AS sigla_uf,
    diretorio_cnae_2_subclasse.descricao_secao AS cnae_2_subclasse_descricao_secao,
    descricao_grau_instrucao_apos_2005 AS grau_instrucao_apos_2005,
    descricao_sexo AS sexo,
    descricao_raca_cor AS raca_cor,
      CASE 
        WHEN idade >= 14 AND idade <= 17 THEN "14 a 17 anos"
        WHEN idade >= 18 AND idade <= 24 THEN "18 a 24 anos"
        WHEN idade >= 25 AND idade <= 39 THEN "25 a 39 anos"
        WHEN idade >= 40 AND idade <= 59 THEN "40 a 59 anos"
        WHEN idade >= 60 THEN "60 anos ou mais"
        ELSE NULL
      END AS faixa_etaria
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = {ano}
),
rais AS (
  SELECT *, CASE 
     -- 4 a 4
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE

    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    ELSE FALSE

  END AS validacao
  FROM filtragem
)

SELECT count(*) FROM rais WHERE validacao = TRUE;


')
s = read_sql(query, billing_project_id = get_billing_id())
return(s$f0_[1])
}

funcao_estoque.5 <- function(ano,local_,sexo_,raca_,idade_,instrucao_,setor_){
  
  set_billing_id("utility-emblem-409417")
  
  query <- glue('
WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "faixa_etaria"
        AND id_tabela = "microdados_vinculos"
),
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "grau_instrucao_apos_2005"
        AND id_tabela = "microdados_vinculos"
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "sexo"
        AND id_tabela = "microdados_vinculos"
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "raca_cor"
        AND id_tabela = "microdados_vinculos"
),

filtragem AS (
SELECT
    dados.sigla_uf AS sigla_uf,
    diretorio_cnae_2_subclasse.descricao_secao AS cnae_2_subclasse_descricao_secao,
    descricao_grau_instrucao_apos_2005 AS grau_instrucao_apos_2005,
    descricao_sexo AS sexo,
    descricao_raca_cor AS raca_cor,
      CASE 
        WHEN idade >= 14 AND idade <= 17 THEN "14 a 17 anos"
        WHEN idade >= 18 AND idade <= 24 THEN "18 a 24 anos"
        WHEN idade >= 25 AND idade <= 39 THEN "25 a 39 anos"
        WHEN idade >= 40 AND idade <= 59 THEN "40 a 59 anos"
        WHEN idade >= 60 THEN "60 anos ou mais"
        ELSE NULL
      END AS faixa_etaria
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = {ano}
),
rais AS (
  SELECT *, CASE 
    -- 5 a 5
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN sexo = "{sexo_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    WHEN raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE
    ELSE FALSE

  END AS validacao
  FROM filtragem
)

SELECT count(*) FROM rais WHERE validacao = TRUE;


')
  s = read_sql(query, billing_project_id = get_billing_id())
  return(s$f0_[1])
}

funcao_estoque.6 <- function(ano,local_,sexo_,raca_,idade_,instrucao_,setor){
  set_billing_id("utility-emblem-409417")
  
  query <- glue('
WITH 
dicionario_faixa_etaria AS (
    SELECT
        chave AS chave_faixa_etaria,
        valor AS descricao_faixa_etaria
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "faixa_etaria"
        AND id_tabela = "microdados_vinculos"
),
dicionario_grau_instrucao_apos_2005 AS (
    SELECT
        chave AS chave_grau_instrucao_apos_2005,
        valor AS descricao_grau_instrucao_apos_2005
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "grau_instrucao_apos_2005"
        AND id_tabela = "microdados_vinculos"
),
dicionario_sexo AS (
    SELECT
        chave AS chave_sexo,
        valor AS descricao_sexo
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "sexo"
        AND id_tabela = "microdados_vinculos"
),
dicionario_raca_cor AS (
    SELECT
        chave AS chave_raca_cor,
        valor AS descricao_raca_cor
    FROM `basedosdados.br_me_rais.dicionario`
    WHERE
        TRUE
        AND nome_coluna = "raca_cor"
        AND id_tabela = "microdados_vinculos"
),

filtragem AS (
SELECT
    dados.sigla_uf AS sigla_uf,
    diretorio_cnae_2_subclasse.descricao_secao AS cnae_2_subclasse_descricao_secao,
    descricao_grau_instrucao_apos_2005 AS grau_instrucao_apos_2005,
    descricao_sexo AS sexo,
    descricao_raca_cor AS raca_cor,
      CASE 
        WHEN idade >= 14 AND idade <= 17 THEN "14 a 17 anos"
        WHEN idade >= 18 AND idade <= 24 THEN "18 a 24 anos"
        WHEN idade >= 25 AND idade <= 39 THEN "25 a 39 anos"
        WHEN idade >= 40 AND idade <= 59 THEN "40 a 59 anos"
        WHEN idade >= 60 THEN "60 anos ou mais"
        ELSE NULL
      END AS faixa_etaria
FROM `basedosdados.br_me_rais.microdados_vinculos` AS dados
LEFT JOIN (SELECT DISTINCT sigla,nome  FROM `basedosdados.br_bd_diretorios_brasil.uf`) AS diretorio_sigla_uf
    ON dados.sigla_uf = diretorio_sigla_uf.sigla
LEFT JOIN (SELECT DISTINCT subclasse,descricao_subclasse,descricao_classe,descricao_grupo,descricao_divisao,descricao_secao  FROM `basedosdados.br_bd_diretorios_brasil.cnae_2`) AS diretorio_cnae_2_subclasse
    ON dados.cnae_2_subclasse = diretorio_cnae_2_subclasse.subclasse
LEFT JOIN `dicionario_grau_instrucao_apos_2005`
    ON dados.grau_instrucao_apos_2005 = chave_grau_instrucao_apos_2005
LEFT JOIN `dicionario_sexo`
    ON dados.sexo = chave_sexo
LEFT JOIN `dicionario_raca_cor`
    ON dados.raca_cor = chave_raca_cor
    WHERE ano = {ano}
),
rais AS (
  SELECT *, CASE 
  
    -- 6 a 6
    WHEN sexo = "{sexo_}" AND raca_cor = "{raca_}" AND faixa_etaria = "{idade_}" AND grau_instrucao_apos_2005 = "{instrucao_}" AND sigla_uf = "{local_}" AND cnae_2_subclasse_descricao_secao = "{setor_}" THEN TRUE

  END AS validacao
  FROM filtragem
)

SELECT count(*) FROM rais WHERE validacao = TRUE;
')
s = read_sql(query, billing_project_id = get_billing_id())
return(s$f0_[1])
}

funcao_estoque <- function(ano,local,sexo,raca,idade,gdi,setor){
  vetor_nulo = c(local,sexo,raca,idade,gdi,setor)
  i = 0
  for(v in vetor_nulo){
    if(v == ""){
      i =  i + 1
    }
  }
  
  if(i == 0){
    return(funcao_estoque.6(ano,local,sexo,raca,idade,gdi,setor))
  }
  
  else if(i == 1){
    return(funcao_estoque.5(ano,local,sexo,raca,idade,gdi,setor))
  }
  else if(i == 2){
    return(funcao_estoque.4(ano,local,sexo,raca,idade,gdi,setor))
  }
  else if(i == 3){
    return(funcao_estoque.3(ano,local,sexo,raca,idade,gdi,setor))
  }
  else if(i == 4){
    return(funcao_estoque.2(ano,local,sexo,raca,idade,gdi,setor))
  }
  else{
    return(funcao_estoque.1(ano,local,sexo,raca,idade,gdi,setor))
  }
}
funcao_estoque(2022,"","","","","MEDIO COMPL","Transporte, Armazenagem e Correio")




