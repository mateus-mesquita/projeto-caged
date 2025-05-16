library(glue)

# Função para filtragem de registros com 1 variável
admissoes_1 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  
  CREATE TABLE admissoes{ano} AS
    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY seção
    
  ")
  
  dbExecute(conexao,query)
}

library(glue)

# Função para filtragem de registros com 1 variável
admissoes_2 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  
  CREATE TABLE admissoes{ano} AS
    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY graudeinstrução, seção
    
  ")
  
  dbExecute(conexao, query)
}

admissoes_3 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  
  CREATE TABLE admissoes{ano} AS
    SELECT uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, graudeinstrução

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, graudeinstrução, seção
    
  ")
  
  dbExecute(conexao, query)
}


admissoes_4 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  
  CREATE TABLE admissoes{ano} AS
    SELECT uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, graudeinstrução

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, graudeinstrução, seção
    
  ")
  
  dbExecute(conexao, query)
}

admissoes_5 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  
  CREATE TABLE admissoes{ano} AS
    SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, seção

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, graudeinstrução, seção
    
  ")
  
  dbExecute(conexao, query)
}

admissoes_6 <- function(tabela, conexao,ano) {
  
  query <- glue::glue("
  
  CREATE TABLE admissoes{ano} AS
    SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS total
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, graudeinstrução, seção
    
  ")
  
  dbExecute(conexao, query)
}

admissoes_6("CAGEDFOR202202",con_for,"for202202")

lista <- list(
  "1" = c("CAGEDFOR202201", "for202201"),
  "2" = c("CAGEDFOR202202", "for202202"),
  "3" = c("CAGEDFOR202203", "for202203"),
  "4" = c("CAGEDFOR202204", "for202204"),
  "5" = c("CAGEDFOR202205", "for202205"),
  "6" = c("CAGEDFOR202206", "for202206"),
  "7" = c("CAGEDFOR202207", "for202207"),
  "8" = c("CAGEDFOR202208", "for202208"),
  "9" = c("CAGEDFOR202209", "for202209"),
  "10" = c("CAGEDFOR202210", "for202210"),
  "11" = c("CAGEDFOR202211", "for202211"),
  "12" = c("CAGEDFOR202212", "for202212")
)

lista_exc <- list(
  "1" = c("CAGEDEXC202201", "exc202201"),
  "2" = c("CAGEDEXC202202", "exc202202"),
  "3" = c("CAGEDEXC202203", "exc202203"),
  "4" = c("CAGEDEXC202204", "exc202204"),
  "5" = c("CAGEDEXC202205", "exc202205"),
  "6" = c("CAGEDEXC202206", "exc202206"),
  "7" = c("CAGEDEXC202207", "exc202207"),
  "8" = c("CAGEDEXC202208", "exc202208"),
  "9" = c("CAGEDEXC202209", "exc202209"),
  "10" = c("CAGEDEXC202210", "exc202210"),
  "11" = c("CAGEDEXC202211", "exc202211"),
  "12" = c("CAGEDEXC202212", "exc202212")
)

lista_mov <- list(
  "1" = c("CAGEDMOV202201", "mov202201"),
  "2" = c("CAGEDMOV202202", "mov202202"),
  "3" = c("CAGEDMOV202203", "mov202203"),
  "4" = c("CAGEDMOV202204", "mov202204"),
  "5" = c("CAGEDMOV202205", "mov202205"),
  "6" = c("CAGEDMOV202206", "mov202206"),
  "7" = c("CAGEDMOV202207", "mov202207"),
  "8" = c("CAGEDMOV202208", "mov202208"),
  "9" = c("CAGEDMOV202209", "mov202209"),
  "10" = c("CAGEDMOV202210", "mov202210"),
  "11" = c("CAGEDMOV202211", "mov202211"),
  "12" = c("CAGEDMOV202212", "mov202212")
)

i = 1
while(i <= 12){
  admissoes_1()
  admissoes_2
  admisssoes_3
  admissoes_4
  admissoes_5
  admissoes_6
  demissoes_1
  demissoes_2
  demissoes_3
  demissoes_4
  demissoes_5
  demissoes_6
}