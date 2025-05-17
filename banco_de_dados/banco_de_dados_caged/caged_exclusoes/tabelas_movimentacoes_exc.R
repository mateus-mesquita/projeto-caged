library(DBI)
library(RSQLite)
library(sqldf)

# Criando tabela de contagem
con_exc = RSQLite::dbConnect(SQLite(),"cagedexc.db")
movimentacao = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")

# Criando tabela de admissoes fora do prazo
dbExecute(movimentacao,'
CREATE TABLE exc_admissoes (
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
CREATE TABLE exc_demissoes (
  mes TEXT,
  uf TEXT,
  sexo TEXT,
  raçacor TEXT,
  faixa_idade TEXT,
  graudeinstrução TEXT,
  seção TEXT,
  demissoes INTEGER
);')



# Lista de meses e arquivos cagede exc
lista_exc <- list(
  "1" = c("janeiro", "CAGEDEXC202301"),
  "2" = c("fevereiro", "CAGEDEXC202302"),
  "3" = c("março", "CAGEDEXC202303"),
  "4" = c("abril", "CAGEDEXC202304"),
  "5" = c("maio", "CAGEDEXC202305"),
  "6" = c("junho", "CAGEDEXC202306"),
  "7" = c("julho", "CAGEDEXC202307"),
  "8" = c("agosto", "CAGEDEXC202308"),
  "9" = c("setembro", "CAGEDEXC202309"),
  "10" = c("outubro", "CAGEDEXC202310"),
  "11" = c("novembro", "CAGEDEXC202311"),
  "12" = c("dezembro", "CAGEDEXC202312")
)


# Loop de inputação
i = 1

while (i <= 12) {
  input_tabela_admissoes(lista_exc[[as.character(i)]][1],movimentacao,"exc_admissoes",con_exc,lista_exc[[as.character(i)]][2])
  input_tabela_demissoes(lista_exc[[as.character(i)]][1],movimentacao,"exc_demissoes",con_exc,lista_exc[[as.character(i)]][2])
  cat("O arquivo ",lista_exc[[as.character(i)]][2],"referente ao mês de",lista_exc[[as.character(i)]][1],"foi executado com sucesso",
      "\n")
  
  i = i + 1
}
