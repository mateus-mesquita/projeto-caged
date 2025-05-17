demissoes_1 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  
  CREATE demissoes{ano}
    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY seção
    
  ")
  
  dbExecute(conexao,query)
}


demissoes_2 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  CREATE demissoes_v2_{ano}
    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY graudeinstrução, seção
  
  
  ")
  dbExecute(conexao,query)
}

demissoes_v3 <- function(tabela, conexao,ano) {
  query <- glue::glue("
  
  CREATE TABLE demissoes_v3_{ano} AS
    SELECT uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, graudeinstrução

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, graudeinstrução, seção
  ")
  
  dbExecute(conexao,query)
}


demissoes_v4 <- function(tabela, conexao, ano) {
  query <- glue::glue("
  CRETE TABLE demissoes_v4_{ano}
    SELECT uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, graudeinstrução

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, graudeinstrução, seção
  )
  ")
  dbExecute(conexao,query)
}


demissoes_v5 <- function(tabela, conexao, ano) {
  query <- glue::glue("
  
  CREATE TABLE demissoes_v5_{ano}
    SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, seção

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, graudeinstrução, seção
  )
  ")
  
  dbExecute(conexao,query)
}


filtragem_6V_demissoes <- function(tabela, conexao, ano) {
  query <- glue::glue("
  CREATE TABLE demissoes_v6_{ano}
    SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação NOT LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, graudeinstrução, seção
  ")
  dbExecute(conexao,query)
}
