# Consulta para sexo e raça:

query_sexo_raca = function(sexo,raca) {
  
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = ""
  and "grau de instrucao" = ""
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

# Consulta para sexo e grau de instrução:
query_sexo_inst = function(sexo,grau_inst){
  
  
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = ""
  and "grau de instrucao" = "{grau_inst}"
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

# Consulta para sexo, raça e grau de instrução:
query_sem_uf = function(sexo,raca,grau_inst) {
  
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = ""
  and "grau de instrucao" = "{grau_inst}"
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

