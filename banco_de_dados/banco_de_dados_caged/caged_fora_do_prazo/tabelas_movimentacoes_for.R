library(DBI)
library(RSQLite)
library(sqldf)

# Criando tabela de contagem
con_for = RSQLite::dbConnect(SQLite(),"cagedfor.db")
movimentacao = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")

# Criando tabela de admissoes fora do prazo
dbExecute(movimentacao,'
CREATE TABLE for_admissoes (
  mes TEXT,
  uf TEXT,
  sexo TEXT,
  raçacor TEXT,
  faixa_idade TEXT,
  graudeinstrução TEXT,
  seção TEXT,
  admissoes INTEGER
);')

# Criando tabela de demissoes fora do prazo
dbExecute(movimentacao,'
CREATE TABLE for_demissoes (
  mes TEXT,
  uf TEXT,
  sexo TEXT,
  raçacor TEXT,
  faixa_idade TEXT,
  graudeinstrução TEXT,
  seção TEXT,
  demissoes INTEGER
);')



# Lista de meses e arquivos cagede for
lista_for <- list(
  "1" = c("janeiro", "CAGEDFOR202301"),
  "2" = c("fevereiro", "CAGEDFOR202302"),
  "3" = c("março", "CAGEDFOR202303"),
  "4" = c("abril", "CAGEDFOR202304"),
  "5" = c("maio", "CAGEDFOR202305"),
  "6" = c("junho", "CAGEDFOR202306"),
  "7" = c("julho", "CAGEDFOR202307"),
  "8" = c("agosto", "CAGEDFOR202308"),
  "9" = c("setembro", "CAGEDFOR202309"),
  "10" = c("outubro", "CAGEDFOR202310"),
  "11" = c("novembro", "CAGEDFOR202311"),
  "12" = c("dezembro", "CAGEDFOR202312")
)

# Loop de inputação
i = 1

while (i <= 12) {
  input_tabela_admissoes(lista_for[[as.character(i)]][1],movimentacao,"for_admissoes",con_for,lista_for[[as.character(i)]][2])
  input_tabela_demissoes(lista_for[[as.character(i)]][1],movimentacao,"for_demissoes",con_for,lista_for[[as.character(i)]][2])
  cat("O arquivo ",lista_for[[as.character(i)]][2],"referente ao mês de",lista_for[[as.character(i)]][1],"foi executado com sucesso",
      "\n")
  
  i = i + 1
}




