library(DBI)
library(RSQLite)
library(sqldf)

# Criando tabela de contagem
con_mov = RSQLite::dbConnect(SQLite(),"cagedmov.db")
movimentacao = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")

# Criando tabela de admissoes fora do prazo
dbExecute(movimentacao,'
CREATE TABLE mov_admissoes (
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
CREATE TABLE mov_demissoes (
  mes TEXT,
  uf TEXT,
  sexo TEXT,
  raçacor TEXT,
  faixa_idade TEXT,
  graudeinstrução TEXT,
  seção TEXT,
  demissoes INTEGER
);')



# Lista de meses e arquivos cagede mov
lista_mov <- list(
  "1" = c("janeiro", "CAGEDMOV202301"),
  "2" = c("fevereiro", "CAGEDMOV202302"),
  "3" = c("março", "CAGEDMOV202303"),
  "4" = c("abril", "CAGEDMOV202304"),
  "5" = c("maio", "CAGEDMOV202305"),
  "6" = c("junho", "CAGEDMOV202306"),
  "7" = c("julho", "CAGEDMOV202307"),
  "8" = c("agosto", "CAGEDMOV202308"),
  "9" = c("setembro", "CAGEDMOV202309"),
  "10" = c("outubro", "CAGEDMOV202310"),
  "11" = c("novembro", "CAGEDMOV202311"),
  "12" = c("dezembro", "CAGEDMOV202312")
)

# Loop de inputação
i = 1

while (i <= 12) {
  input_tabela_admissoes(lista_mov[[as.character(i)]][1],movimentacao,"mov_admissoes",con_mov,lista_mov[[as.character(i)]][2])
  input_tabela_demissoes(lista_mov[[as.character(i)]][1],movimentacao,"mov_demissoes",con_mov,lista_mov[[as.character(i)]][2])
  cat("O arquivo ",lista_mov[[as.character(i)]][2],"referente ao mês de",lista_mov[[as.character(i)]][1],"foi executado com sucesso",
      "\n")
  
  i = i + 1
}
