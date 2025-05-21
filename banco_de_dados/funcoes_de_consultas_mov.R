# Teste de consultas

query_for<- function(mes,local,sexo,raca,idade,gdi,setor,admissao){
  
if(admissao == TRUE){
  arquivo = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")
  
  query = glue::glue(
    '
    SELECT DISTINCT admissoes FROM for_admissoes
    WHERE uf = "{local}" AND mes = "{mes}" AND
    sexo = "{sexo}" AND raçacor = "{raca}"
    AND faixa_idade = "{idade}" AND graudeinstrução = "{gdi}"
    AND seção = "{setor}";
    '
  )
  resultado = dbGetQuery(arquivo,query)
  if(length(resultado$admissoes) == 0){
    return(0)
  }
  else{
    return(as.numeric(resultado$admissoes))
  } 
} else{
  arquivo = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")
  
  query = glue::glue(
    '
    SELECT DISTINCT demissoes FROM for_demissoes
    WHERE uf = "{local}" AND mes = "{mes}" AND
    sexo = "{sexo}" AND raçacor = "{raca}"
    AND faixa_idade = "{idade}" AND graudeinstrução = "{gdi}"
    AND seção = "{setor}";
    '
  )
  resultado = dbGetQuery(arquivo,query)
  if(length(resultado$demissoes) == 0){
    return(0)
  }
  else{
    return(as.numeric(resultado$demissoes))
  }
 }
}

query_mov <- function(mes,local,sexo,raca,idade,gdi,setor,admissao){
  
  if(admissao == TRUE){
    arquivo = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")
    
    query = glue::glue(
      '
      SELECT DISTINCT admissoes FROM mov_admissoes
      WHERE uf = "{local}" AND mes = "{mes}" AND
      sexo = "{sexo}" AND raçacor = "{raca}"
      AND faixa_idade = "{idade}" AND graudeinstrução = "{gdi}"
      AND seção = "{setor}";
      '
    )
    resultado = dbGetQuery(arquivo,query)
    if(length(resultado$admissoes) == 0){
      return(0)
    }
    else{
      return(as.numeric(resultado$admissoes))
    } 
  } else{
    arquivo = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")
    
    query = glue::glue(
      '
      SELECT DISTINCT demissoes FROM mov_demissoes
      WHERE uf = "{local}" AND mes = "{mes}" AND
      sexo = "{sexo}" AND raçacor = "{raca}"
      AND faixa_idade = "{idade}" AND graudeinstrução = "{gdi}"
      AND seção = "{setor}";
      '
    )
    resultado = dbGetQuery(arquivo,query)
    if(length(resultado$demissoes) == 0){
      return(0)
    }
    else{
      return(as.numeric(resultado$demissoes))
    }
  }
}

query_exc <- function(mes,local,sexo,raca,idade,gdi,setor,admissao){
  
  if(admissao == TRUE){
    arquivo = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")
    
    query = glue::glue(
      '
      SELECT DISTINCT admissoes FROM exc_admissoes
      WHERE uf = "{local}" AND mes = "{mes}" AND
      sexo = "{sexo}" AND raçacor = "{raca}"
      AND faixa_idade = "{idade}" AND graudeinstrução = "{gdi}"
      AND seção = "{setor}";
      '
    )
    resultado = dbGetQuery(arquivo,query)
    if(length(resultado$admissoes) == 0){
      return(0)
    }
    else{
      return(as.numeric(resultado$admissoes))
    } 
  } 
  else{
    arquivo = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")
    
    query = glue::glue(
      '
      SELECT DISTINCT demissoes FROM exc_demissoes
      WHERE uf = "{local}" AND mes = "{mes}" AND
      sexo = "{sexo}" AND raçacor = "{raca}"
      AND faixa_idade = "{idade}" AND graudeinstrução = "{gdi}"
      AND seção = "{setor}";
      '
    )
    resultado = dbGetQuery(arquivo,query)
    if(length(resultado$demissoes) == 0){
      return(0)
    }
    else{
      return(as.numeric(resultado$demissoes))
    }
  }
}

for(local_ in local){
  for(sexo_ in sexo){
    for(raca_ in raca_cor){
      for(idade_ in idades){
        for(gdi_ in grau_de_instrucao){
          for(setor_ in setores){
            
            q = query_exc('janeiro',local_,sexo_,raca_,idade_,gdi_,setor_,FALSE)
            cat(local_,sexo_,raca_,idade_,gdi_,setor_,q,'\n')
          }
        }
      }
    }
  }
}
query_for("BA","","","","","")
library(Rcpp)

Rcpp::sourceCpp("planilha_final.cpp")

system.time({
  dados = enumerarConjuntos(local,sexo,raca_cor,idades,grau_de_instrucao,setores) } 
)

