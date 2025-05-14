library(glue)

# Função para filtragem de registros com 1 variável
filtragem_1V = function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_) {
  
  # Criação da query SQL com CTE (Common Table Expression)
  query <- glue::glue("
    SELECT count(*) FROM {tabela} WHERE (tipomovimentação LIKE '%Admissao%' AND uf = '{local_}') OR  
    (tipomovimentação LIKE '%Admissao%' AND sexo = '{sexo_}') OR
      (tipomovimentação LIKE '%Admissao%' AND raçacor = '{raca_}') OR 
      (tipomovimentação LIKE '%Admissao%' AND faixa_idade = '{idade_}') OR 
      (tipomovimentação LIKE '%Admissao%' AND graudeinstrução = '{gdi_}')
      OR (tipomovimentação LIKE '%Admissao%' AND seção = '{setor_}');
  ")

# Executa a query no banco de dados e retorna o resultado
df = dbGetQuery(conexao, query)
return(df$count[[1]])
}

filtragem_2V <- function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_){
  query <- glue::glue(
    "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%' AND (
    (uf = '{local_}' AND sexo = '{sexo_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}') OR
    (uf = '{local_}' AND faixa_idade = '{idade_}') OR
    (uf = '{local_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}') OR
    (sexo = '{sexo_}' AND faixa_idade = '{idade_}') OR
    (sexo = '{sexo_}' AND graudeinstrução = '{gdi_}') OR
    (sexo = '{sexo_}' AND seção = '{setor_}') OR
    (raçacor = '{raca_}' AND faixa_idade = '{idade_}') OR
    (raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') OR
    (raçacor = '{raca_}' AND seção = '{setor_}') OR
    (faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (graudeinstrução = '{gdi_}' AND seção = '{setor_}')
    );
    "
  )
  df = dbGetQuery(conexao, query)
  return(df$count[[1]])
}


# Função para filtragem de registros com 3 variáveis
filtragem_3V <- function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_){
  query <- glue::glue(
    "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%' AND (
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}')
    );
    "
  )
  df = dbGetQuery(conexao, query)
  return(df$count[[1]])
}


filtragem_4V <- function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_){
  query <- glue::glue(
    "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%' AND (
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}')
    );
    "
  )
  df = dbGetQuery(conexao, query)
  return(df$count[[1]])
}


filtragem_5V <- function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_){
  query <- glue::glue(
    "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%' AND (
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') OR
    (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}')
    );
    "
  )
  df = dbGetQuery(conexao, query)
  return(df$count[[1]])
}

filtragem_6V <- function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_){
  query <- glue::glue(
    "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%' AND (
    (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}')
    );
    "
  )
  df = dbGetQuery(conexao, query)
  return(df$count[[1]])}



contagem.mov.for <- function(tabela,local,sexo,raca,idade,gdi,setor){
  
  conexao = RSQLite::dbConnect(SQLite(),"cagedfor.db")
    
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
    return(as.numeric(resultado)) 
  }
  else if(i == 4){
    resultado = filtragem_2V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 3){
    resultado = filtragem_3V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 2){
    resultado = filtragem_4V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 1){
    resultado = filtragem_5V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else{
    resultado = filtragem_6V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
}

contagem.mov.exc <- function(tabela,local,sexo,raca,idade,gdi,setor){
  
  conexao = RSQLite::dbConnect(SQLite(),"cagedexc.db")
  
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
    return(as.numeric(resultado)) 
  }
  else if(i == 4){
    resultado = filtragem_2V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 3){
    resultado = filtragem_3V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 2){
    resultado = filtragem_4V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 1){
    resultado = filtragem_5V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else{
    resultado = filtragem_6V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
}

contagem.mov.mov <- function(tabela,local,sexo,raca,idade,gdi,setor){
  
  conexao = RSQLite::dbConnect(SQLite(),"cagedmov.db")
  
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
    return(as.numeric(resultado)) 
  }
  else if(i == 4){
    resultado = filtragem_2V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 3){
    resultado = filtragem_3V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 2){
    resultado = filtragem_4V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else if(i == 1){
    resultado = filtragem_5V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
  else{
    resultado = filtragem_6V(tabela,conexao,local,sexo,raca,idade,gdi,setor)
    return(as.numeric(resultado)) 
  }
}




for(local_ in local){
  for(sexo_ in sexo){
    for(raca_ in raca_cor){
      for(idade_ in idades){
        for(gdi_ in grau_de_instrucao){
          for(setor_ in setores){
            cat(local_,sexo_,raca_,idade_,gdi_,setor_,
                contagem.mov.for('CAGEDFOR202201',local_,sexo_,raca_,idade_,gdi_,setor_),
                contagem.mov_demissoes.for('CAGEDFOR202201',local_,sexo_,raca_,idade_,gdi_,setor_),"\n")
          }
        }
      }
    }
  }
}


