# povoando a tabela de exclusões

con <- dbConnect(RSQLite::SQLite(), "cagedexc_dados.sqlite")

# Criando uma tabela no banco de dados
dbExecute(con, "
  CREATE TABLE cagedexc (
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
          INSERT INTO cagedexc (mes, local, sexo, cor, instrucao, admissoes, demissoes)
          VALUES 
          ("março", "{local_}", "{sexo_}", "{raca_cor_}", "{gdi_}",
         {contador({filtro({dados},{local_}, {sexo_}, {raca_cor_}, {gdi_})}, TRUE)},
         {contador({filtro({dados},{local_}, {sexo_}, {raca_cor_}, {gdi_})}, FALSE)})
        ')
        
        dbExecute(con,query)
        
      }
    }
  }
}


conjunto_de_dados = list(
  janeiro = c('CAGEDEXC202201.txt', 'janeiro'),
  fevereiro = c('CAGEDEXC202202.txt', 'fevereiro'),
  março = c('CAGEDEXC202203.txt', 'março'),
  abril = c('CAGEDEXC202204.txt', 'abril'),
  maio = c('CAGEDEXC202205.txt', 'maio'),
  junho = c('CAGEDEXC202206.txt', 'junho'),
  julho = c('CAGEDEXC202207.txt', 'julho'),
  agosto = c('CAGEDEXC202208.txt', 'agosto'),
  setembro = c('CAGEDEXC202209.txt', 'setembro'),
  outubro = c('CAGEDEXC202210.txt', 'outubro'),
  novembro = c('CAGEDEXC202211.txt', 'novembro'),
  dezembro = c('CAGEDEXC202212.txt', 'dezembro')
)



for(i in conjunto_de_dados){
  cageds <- i[1]
  dados = preprocessamento(cageds)

  
  for (local_ in local) {
    for(sexo_ in sexo){
      for(raca_cor_ in raca_cor){
        for(gdi_ in grau_de_instrucao){
          
          
          query <- glue('
          INSERT INTO cagedexc (mes, local, sexo, cor, instrucao, admissoes, demissoes)
          VALUES 
          ("{i[2]}", "{local_}", "{sexo_}", "{raca_cor_}", "{gdi_}",
         {contador({filtro({dados},{local_}, {sexo_}, {raca_cor_}, {gdi_})}, TRUE)},
         {contador({filtro({dados},{local_}, {sexo_}, {raca_cor_}, {gdi_})}, FALSE)})
        ')
          
          dbExecute(con,query)
          
        }
      }
    }
  }
  
}

clientes <- dbGetQuery(con, "SELECT * FROM cagedexc")
print(filter(clientes,mes == "abril"))
