# Sem raça:

query_sem_raca = function(uf,sexo,grau_inst) {
 
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = "{uf}"
  and "grau de instrucao" = "{grau_inst}"
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}
 