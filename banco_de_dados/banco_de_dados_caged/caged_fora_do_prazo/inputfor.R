library(RSQLite)
library(DBI)
library(dplyr)
resultado_bd = RSQLite::dbConnect(SQLite(),"cagedfor.db")
'''
lista = list(
  "1" = c("CAGEDFOR202201", "cagedfor202201.txt"),
  "2" = c("CAGEDFOR202202", "cagedfor202202.txt"),
  "3" = c("CAGEDFOR202203", "cagedfor202203.txt"),
  "4" = c("CAGEDFOR202204", "cagedfor202204.txt"),
  "5" = c("CAGEDFOR202205", "cagedfor202205.txt"),
  "6" = c("CAGEDFOR202206", "cagedfor202206.txt"),
  "7" = c("CAGEDFOR202207", "cagedfor202207.txt"),
  "8" = c("CAGEDFOR202208", "cagedfor202208.txt"),
  "9" = c("CAGEDFOR202209", "cagedfor202209.txt"),
  "10" = c("CAGEDFOR202210", "cagedfor202210.txt"),
  "11" = c("CAGEDFOR202211", "cagedfor202211.txt"),
  "12" = c("CAGEDFOR202212", "cagedfor202212.txt")
)
'''

lista = list(
  "1" = c("CAGEDFOR202301", "cagedfor202301.txt"),
  "2" = c("CAGEDFOR202302", "cagedfor202302.txt"),
  "3" = c("CAGEDFOR202303", "cagedfor202303.txt"),
  "4" = c("CAGEDFOR202304", "cagedfor202304.txt"),
  "5" = c("CAGEDFOR202305", "cagedfor202305.txt"),
  "6" = c("CAGEDFOR202306", "cagedfor202306.txt"),
  "7" = c("CAGEDFOR202307", "cagedfor202307.txt"),
  "8" = c("CAGEDFOR202308", "cagedfor202308.txt"),
  "9" = c("CAGEDFOR202309", "cagedfor202309.txt"),
  "10" = c("CAGEDFOR202310", "cagedfor202310.txt"),
  "11" = c("CAGEDFOR202311", "cagedfor202311.txt"),
  "12" = c("CAGEDFOR202312", "cagedfor202312.txt")
)

i = 1
while(i <= 12){
  tabela = lista[[as.character(i)]][1]
  arquivo = lista[[as.character(i)]][2]
  df = preprocessamento(arquivo)
  dbWriteTable(resultado_bd,tabela,df,append = TRUE)
  i = i + 1
  
}

