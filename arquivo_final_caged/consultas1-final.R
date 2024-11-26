query_sexo = function(sexo) {
 
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "{sexo}" 
  and estado = ""
  and "grau de instrucao" = ""
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}
# Consulta que retorna apenas as raças:

query_raca = function(raca) {

  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = ""
  and "grau de instrucao" = ""
  and raca = "{raca}";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}
 
