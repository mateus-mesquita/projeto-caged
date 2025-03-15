# banco de dados caged for

# Conectando a um banco de dados SQLite (arquivo local)
con <- dbConnect(RSQLite::SQLite(), "cagedfor_dados.sqlite")

# Criando uma tabela no banco de dados
dbExecute(con, "
  CREATE TABLE cagedfor (
    mes TEXT,
    local TEXT,
    sexo TEXT,
    cor TEXT,
    instrucao TEXT,
    admissoes INTEGER,
    demissoes INTEGER
  )
")

# preenchendo a tabela

for (local_ in local) {
  for(sexo_ in sexo){
    for(raca_cor_ in raca_cor){
      for(gdi_ in grau_de_instrucao){
        query <- glue('
          INSERT INTO cagedfor (mes, local, sexo, cor, instrucao, admissoes, demissoes)
          VALUES 
          ("dezembro", "{local_}", "{sexo_}", "{raca_cor_}", "{gdi_}",
         {contador({filtro({teste},{local_}, {sexo_}, {raca_cor_}, {gdi_})}, TRUE)},
         {contador({filtro({teste},{local_}, {sexo_}, {raca_cor_}, {gdi_})}, FALSE)})
        ')
       
        dbExecute(con,query)
         
      }
    }
  }
}


clientes <- dbGetQuery(con, "SELECT * FROM cagedfor")
print(clientes)


