library(RSQLite)
library(DBI)
library(dplyr)
resultado_bd = RSQLite::dbConnect(SQLite(),"cagedmov.db")

lista = list(
  "6" = c("CAGEDMOV202306", "cagedmov202306.txt"),
  "7" = c("CAGEDMOV202307", "cagedmov202307.txt"),
  "8" = c("CAGEDMOV202308", "cagedmov202308.txt"),
  "9" = c("CAGEDMOV202309", "cagedmov202309.txt"),
  "10" = c("CAGEDMOV202310", "cagedmov202310.txt"),
  "11" = c("CAGEDMOV202311", "cagedmov202311.txt"),
  "12" = c("CAGEDMOV202312", "cagedmov202312.txt")
)


i = 1
while(i <= 12){
  tabela = lista[[as.character(i)]][1]
  arquivo = lista[[as.character(i)]][2]
  df = preprocessamento(arquivo)
  dbWriteTable(resultado_bd,tabela,df,append = TRUE)
  i = i + 1
  cat("Arquivo",arquivo,"referente a tabela",tabela,'foi executado com sucesso','\n')
}
n   