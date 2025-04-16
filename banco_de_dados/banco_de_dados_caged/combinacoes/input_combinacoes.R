# Povoando tabela de combinações

con <- dbConnect(
  RPostgres::Postgres(),
  dbname = "combinacoes",
  host = "127.0.0.1",    # IP do servidor
  port = 5432,
  user = "postgres",
  password = "030922"
)

i = 0
for(mes_ in mes){
  for(local_ in local){
    for(sexo_ in sexo){
      for(raca_ in raca_cor){
        for(idade_ in idades){
          for(gdi_ in grau_de_instrucao){
            for (setor_ in setores) {
            i = i + 1
            }
          }
        }
      }
    }
  }
}
# Criando tabela
id = seq(1,i,1)
df = data.frame(id)

#combinações
comb = tidyr::expand_grid(mes,local,sexo,raca_cor,idades,grau_de_instrucao,setores)


# criando colunas
df$mes = comb$mes
df$uf = comb$local
df$sexo = comb$sexo
df$raca = comb$raca_cor
df$idade = comb$idades
df$gdi = comb$grau_de_instrucao
df$cnae = setores

dbWriteTable(con,"combinacoes1",df,append = TRUE)
