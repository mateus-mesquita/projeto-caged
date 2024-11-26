
# Consulta para raça e grau de instrução:
query_raca_inst = function(raca,grau_inst) {
  
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = ""
  and "grau de instrucao" = "{grau_inst}"
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

# Consulta para uf, sexo e grau de instrução:
query_sem_sx = function(uf,raca,grau_inst) {
  
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = "{uf}"
  and "grau de instrucao" = "{grau_inst}"
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}
