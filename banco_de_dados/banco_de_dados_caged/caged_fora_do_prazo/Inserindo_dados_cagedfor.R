# lista de dados
lista = list(
  "1" = c("cagedfor202201", "CAGEDFOR202201.txt"),
  "2" = c("cagedfor202202", "CAGEDFOR202202.txt"),
  "3" = c("cagedfor202203", "CAGEDFOR202203.txt"),
  "4" = c("cagedfor202204", "CAGEDFOR202204.txt"),
  "5" = c("cagedfor202205", "CAGEDFOR202205.txt"),
  "6" = c("cagedfor202206", "CAGEDFOR202206.txt"),
  "7" = c("cagedfor202207", "CAGEDFOR202207.txt"),
  "8" = c("cagedfor202208", "CAGEDFOR202208.txt"),
  "9" = c("cagedfor202209", "CAGEDFOR202209.txt"),
  "10" = c("cagedfor202210", "CAGEDFOR202210.txt"),
  "11" = c("cagedfor202211", "CAGEDFOR202211.txt"),
  "12" = c("cagedfor202212", "CAGEDFOR202212.txt")
)

# povoando tabela do CAGED fora do prazo
InsertTables(lista,con)
