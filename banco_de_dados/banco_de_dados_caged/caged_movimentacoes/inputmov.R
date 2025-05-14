library(RSQLite)
library(DBI)
library(dplyr)
resultado_bd = RSQLite::dbConnect(SQLite(),"cagedmov.db")

lista = list(
  "1" = c("CAGEDMOV202201", "cagedmov202201.txt"),
  "2" = c("CAGEDMOV202202", "cagedmov202202.txt"),
  "3" = c("CAGEDMOV202203", "cagedmov202203.txt"),
  "4" = c("CAGEDMOV202204", "cagedmov202204.txt"),
  "5" = c("CAGEDMOV202205", "cagedmov202205.txt"),
  "6" = c("CAGEDMOV202206", "cagedmov202206.txt"),
  "7" = c("CAGEDMOV202207", "cagedmov202207.txt"),
  "8" = c("CAGEDMOV202208", "cagedmov202208.txt"),
  "9" = c("CAGEDMOV202209", "cagedmov202209.txt"),
  "10" = c("CAGEDMOV202210", "cagedmov202210.txt"),
  "11" = c("CAGEDMOV202211", "cagedmov202211.txt"),
  "12" = c("CAGEDMOV202212", "cagedmov202212.txt")
)

i = 1
while(i <= 12){
  tabela = lista[[as.character(i)]][1]
  arquivo = lista[[as.character(i)]][2]
  df = preprocessamento(arquivo)
  dbWriteTable(resultado_bd,tabela,df,append = TRUE)
  i = i + 1
  
}
   