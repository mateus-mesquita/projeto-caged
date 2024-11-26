# Consulta para uf e sexo:
query_uf1 = function(uf,sexo) {
 
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = "{uf}"
  and "grau de instrucao" = ""
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

# Consulta para uf, sexo e raça:
query_sem_instrucao = function(uf,sexo,raca) {
 
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = "{uf}"
  and "grau de instrucao" = ""
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

# Consulta para uf,raça,sexo e grau de intrução:
query_geral = function(uf,raca,sexo,grau_inst) {
  
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = "{uf}"
  and "grau de instrucao" = "{grau_inst}"
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

#Consulta para uf e grau de instrução:

query_uf_raca = function(uf,raca) {

 
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = "{uf}"
  and "grau de instrucao" = ""
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

# Consulta para uf e grau de instrução:
query_graus_uf = function(uf,grau_inst) {

 
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = "{uf}"
  and "grau de instrucao" = "{grau_inst}"
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
} 
