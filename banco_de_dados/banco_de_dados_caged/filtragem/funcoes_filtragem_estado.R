library(glue)

# Função para filtragem de registros com 1 variável
filtragem_1V <- function(tabela, conexao) {
  
  query <- glue::glue("
    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY seção
    
  ")
  
  df <- DBI::dbGetQuery(conexao, query)
  return(df)
}


filtragem_2V <- function(conexao,tabela) {
  
  query <- glue::glue("
    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY graudeinstrução, seção
  
  ")
  
  df <- DBI::dbGetQuery(conexao, query)
  return(df)
}



filtragem_3V <- function(conexao,tabela) {
  query <- glue::glue("
  
    SELECT uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, graudeinstrução

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY faixa_idade, graudeinstrução, seção
  ")
  
  df <- DBI::dbGetQuery(conexao, query)
  return(df)
}


filtragem_4V <- function(conexao,tabela) {
  query <- glue::glue(" 
    SELECT uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, graudeinstrução

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY raçacor, faixa_idade, graudeinstrução, seção
  ")
  
  df <- DBI::dbGetQuery(conexao, query)
  return(df)
}


filtragem_5V <- function(conexao,tabela) {
  query <- glue::glue("
  
    SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, '' AS seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, graudeinstrução

  UNION ALL

    SELECT uf, sexo, raçacor, faixa_idade, '' AS graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, seção

  UNION ALL

    SELECT uf, sexo, raçacor, '' AS faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, graudeinstrução, seção

  UNION ALL

    SELECT uf, sexo, '' AS raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT uf, '' AS sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, raçacor, faixa_idade, graudeinstrução, seção

  UNION ALL

    SELECT '' AS uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY sexo, raçacor, faixa_idade, graudeinstrução, seção
  ")
  
  df <- DBI::dbGetQuery(conexao, query)
  return(df)
}



filtragem_6V <- function(conexao,tabela) {
  query <- glue::glue("
    SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, COUNT(*) AS admissoes
    FROM {tabela}
    WHERE tipomovimentação LIKE '%Admissao%' AND uf IN ('CE','PE','BA')
    GROUP BY uf, sexo, raçacor, faixa_idade, graudeinstrução, seção
  ")
  
  df <- DBI::dbGetQuery(conexao, query)
  return(df)
}

contagem_admissoes <- function(tabela,conexao,local,sexo,raca,idade,gdi,setor){
  
  v = c(local,sexo,raca,idade,gdi,setor)
  i = 0
  for(v_ in v){
    if(v_ == ''){
      i = i + 1
    }
  }
  if(local == "" & sexo == "" & raca == "" & idade == "" & gdi == "" & setor == ""){
    query <- glue::glue(
      "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%';
    "
    )
    df = dbGetQuery(conexao, query)
    return(as.numeric(df$count[[1]]))
  }
  else if(i == 5){
    resultado = filtragem_1V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    resultado_final = ifelse(nrow(resultado) == 0,0,resultado)
    return(as.numeric(resultado_final))  
  }
  else if(i == 4){
    resultado = filtragem_2V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    resultado_final = ifelse(nrow(resultado) == 0,0,resultado)
    return(as.numeric(resultado_final))   
  }
  else if(i == 3){
    resultado = filtragem_3V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    resultado_final = ifelse(nrow(resultado) == 0,0,resultado)
    return(as.numeric(resultado_final)) 
  }
  else if(i == 2){
    resultado = filtragem_4V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    resultado_final = ifelse(nrow(resultado) == 0,0,resultado)
    return(as.numeric(resultado_final))  
  }
  else if(i == 1){
    resultado = filtragem_5V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    resultado_final = ifelse(nrow(resultado) == 0,0,resultado)
    return(as.numeric(resultado_final))   
  }
  else{
    resultado = filtragem_6V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    resultado_final = ifelse(length(resultado) == 0,0,resultado)
    return(as.numeric(resultado_final)) 
  }
}



i = 1
for(local_ in local){
  for(sexo_ in sexo){
    for(raca_ in raca_cor){
      for(idade_ in idades){
        for(gdi_ in grau_de_instrucao){
          for(setor_ in setores){
            cat(i,local_,sexo_,raca_,idade_,gdi_,setor_,
                contagem_admissoes('CAGEDMOV202201',con_mov,local_,sexo_,raca_,idade_,gdi_,setor_) - contagem_demissoes('CAGEDMOV202201',con_mov,local_,sexo_,raca_,idade_,gdi_,setor_)
                + contagem_admissoes('CAGEDFOR202201',con_for,local_,sexo_,raca_,idade_,gdi_,setor_) - contagem_demissoes('CAGEDFOR202201',con_for,local_,sexo_,raca_,idade_,gdi_,setor_)
                - contagem_admissoes('CAGEDEXC202201',con_exc,local_,sexo_,raca_,idade_,gdi_,setor_) + contagem_demissoes('CAGEDEXC202201',con_exc,local_,sexo_,raca_,idade_,gdi_,setor_),"\n")
            i = i + 1

          }
        }
      }
    }
  }
}

df = filtragem_6V("CAGEDFOR202201",con_for)
sum(df$`COALESCE(contagem.total, 0)` == 0)

