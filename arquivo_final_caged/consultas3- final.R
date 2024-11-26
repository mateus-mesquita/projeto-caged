## Criando funções de consultas:

#Função que retorna a consulta para todas as condições estarem em branco:
query = function() {
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = ""
  and "grau de instrucao" = ""
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}

#----------------------

# Consulta considerando apenas os estados:
query_estados = function(uf) {
  
  sqlite = dbDriver("SQLite")
  
  con =  dbConnect(sqlite,"rais.db")
  
  consulta = glue('
  Select estoque from RAIS
  where sexo = "" 
  and estado = "{uf}"
  and "grau de instrucao" = ""
  and raca = "";
  ')
  
  resultado = dbGetQuery(con, consulta)
  
  return(resultado[[1]])
}
