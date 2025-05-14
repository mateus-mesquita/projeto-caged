library(RSQLite)
library(DBI)
library(dplyr)
resultado_bd = RSQLite::dbConnect(SQLite(),"cagedexc.db")

'''
lista = list(
  "1" = c("CAGEDEXC202201", "cagedexc202201.txt"),
  "2" = c("CAGEDEXC202202", "cagedexc202202.txt"),
  "3" = c("CAGEDEXC202203", "cagedexc202203.txt"),
  "4" = c("CAGEDEXC202204", "cagedexc202204.txt"),
  "5" = c("CAGEDEXC202205", "cagedexc202205.txt"),
  "6" = c("CAGEDEXC202206", "cagedexc202206.txt"),
  "7" = c("CAGEDEXC202207", "cagedexc202207.txt"),
  "8" = c("CAGEDEXC202208", "cagedexc202208.txt"),
  "9" = c("CAGEDEXC202209", "cagedexc202209.txt"),
  "10" = c("CAGEDEXC202210", "cagedexc202210.txt"),
  "11" = c("CAGEDEXC202211", "cagedexc202211.txt"),
  "12" = c("CAGEDEXC202212", "cagedexc202212.txt")
)
'''

lista = list(
  "1" = c("CAGEDEXC202301", "cagedexc202301.txt"),
  "2" = c("CAGEDEXC202302", "cagedexc202302.txt"),
  "3" = c("CAGEDEXC202303", "cagedexc202303.txt"),
  "4" = c("CAGEDEXC202304", "cagedexc202304.txt"),
  "5" = c("CAGEDEXC202305", "cagedexc202305.txt"),
  "6" = c("CAGEDEXC202306", "cagedexc202306.txt"),
  "7" = c("CAGEDEXC202307", "cagedexc202307.txt"),
  "8" = c("CAGEDEXC202308", "cagedexc202308.txt"),
  "9" = c("CAGEDEXC202309", "cagedexc202309.txt"),
  "10" = c("CAGEDEXC202310", "cagedexc202310.txt"),
  "11" = c("CAGEDEXC202311", "cagedexc202311.txt"),
  "12" = c("CAGEDEXC202312", "cagedexc202312.txt")
)

i = 1
while(i <= 12){
  tabela = lista[[as.character(i)]][1]
  arquivo = lista[[as.character(i)]][2]
  df = preprocessamento(arquivo)
  dbWriteTable(resultado_bd,tabela,df,append = TRUE)
  i = i + 1
  
}
