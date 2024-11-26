# Consultando os graus de instrução:

query_grau_inst = function(grau_inst) {
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = ""
  and "grau de instrucao" = "{grau_inst}"
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}


sqlite = dbDriver("SQLite")

con =  dbConnect(sqlite,"rais.db")

consulta = '
  Select estoque from RAIS
  where sexo = "feminino" 
  and estado = "PE"
  and "grau de instrucao" = "MEDIO INCOMP"
  and raca = "Não indentificada";
  '

resultado = dbGetQuery(con, consulta)

print(as.numeric(resultado[[1]]))
