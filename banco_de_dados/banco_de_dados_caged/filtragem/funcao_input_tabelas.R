# Criando Tabelas de contagem de admissões
library(DBI)
library(sqldf)
library(RSQLite)

# Criando tabela de contagem
con_for = RSQLite::dbConnect(SQLite(),"cagedfor.db")
movimentacao = RSQLite::dbConnect(SQLite(),"movimentacao_dados.db")

# Criando tabela de teste
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
input_admissao_geral <- function(conexao,tabela){
 
  query <- glue::glue(
    "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação LIKE '%Admissao%';
    "
  )
  df = dbGetQuery(conexao, query)
  return(as.numeric(df$count[[1]]))
  
}

input_demissoes_geral <- function(conexao,tabela){
  
  query <- glue::glue(
    "
    SELECT count(*) FROM {tabela} WHERE tipomovimentação NOT LIKE '%Admissao%';
    "
  )
  df = dbGetQuery(conexao, query)
  return(as.numeric(df$count[[1]]))
  
}

# Função de imputação de tabelas
input_tabela_admissoes <- function(mes,conexao_admissoes,tabela,conexao_arquivo,arquivo){
  # dados geral 
  dados = list(
    "uf" = "",
    "sexo" = "",
    "raçacor" = "",
    "faixa_idade" = "",
    "graudeinstrução" = "",
    "seção" = "",
    "admissoes" = input_admissao_geral(conexao_arquivo,arquivo)
  )
  
  dados_geral = data.frame(dados)
  
  # Inputando contagem de uma variável
  dados_contagem_uma_variavel = filtragem_1V(arquivo,conexao_arquivo)
  
  # inputando dados de duas variáveis
  dados_contagem_duas_variavel = filtragem_2V(conexao_arquivo,arquivo)
  
  # Inputando dados de três variáveis
  dados_contagem_tres_variavel = filtragem_3V(conexao_arquivo,arquivo)
  
  # Inputando dados de quatro variáveis
  dados_contagem_quatro_variavel = filtragem_4V(conexao_arquivo,arquivo)
  
  # Inputando dados de cinco variáveis
  dados_contagem_cinco_variavel = filtragem_5V(conexao_arquivo,arquivo)
  
  # Inputando dados de 6 variáveis
  dados_contagem_seis_variavel = filtragem_6V(conexao_arquivo,arquivo)
  
  df_final = rbind(dados_geral,dados_contagem_uma_variavel,dados_contagem_duas_variavel,
                   dados_contagem_tres_variavel,dados_contagem_quatro_variavel,
                   dados_contagem_cinco_variavel,dados_contagem_seis_variavel)
  
  # Contagem dos meses
  mes = rep(mes,nrow(df_final))
  dados = cbind(mes,df_final)
  
  dbWriteTable(conexao_admissoes,tabela,dados,append = TRUE)
}

# Função de imputação de tabelas
input_tabela_demissoes <- function(mes,conexao_demissoes,tabela,conexao_arquivo,arquivo){
  # dados geral 
  dados = list(
    "uf" = "",
    "sexo" = "",
    "raçacor" = "",
    "faixa_idade" = "",
    "graudeinstrução" = "",
    "seção" = "",
    "demissoes" = input_demissoes_geral(conexao_arquivo,arquivo)
  )
  
  dados_geral = data.frame(dados)
  
  # Inputando contagem de uma variável
  dados_contagem_uma_variavel = filtragem_1V_demissoes(conexao_arquivo,arquivo)
  
  # inputando dados de duas variáveis
  dados_contagem_duas_variavel = filtragem_2V_demissoes(conexao_arquivo,arquivo)
  
  # Inputando dados de três variáveis
  dados_contagem_tres_variavel = filtragem_3V_demissoes(conexao_arquivo,arquivo)
  
  # Inputando dados de quatro variáveis
  dados_contagem_quatro_variavel = filtragem_4V_demissoes(conexao_arquivo,arquivo)
  
  # Inputando dados de cinco variáveis
  dados_contagem_cinco_variavel = filtragem_5V_demissoes(conexao_arquivo,arquivo)
  
  # Inputando dados de 6 variáveis
  dados_contagem_seis_variavel = filtragem_6V_demissoes(conexao_arquivo,arquivo)
  
  df_final = rbind(dados_geral,dados_contagem_uma_variavel,dados_contagem_duas_variavel,
                   dados_contagem_tres_variavel,dados_contagem_quatro_variavel,
                   dados_contagem_cinco_variavel,dados_contagem_seis_variavel)
  
  # Contagem dos meses
  mes = rep(mes,nrow(df_final))
  dados = cbind(mes,df_final)
  
  dbWriteTable(conexao_demissoes,tabela,dados,append = TRUE)
}

dados = input_tabela_admissoes('janeiro','',"",con_for,"CAGEDFOR202201")
dados_ = input_tabela_demissoes('janeiro','',"",con_for,"CAGEDFOR202202")


