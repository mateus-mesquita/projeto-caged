# inputação dos dados:
library(glue)          # Construção de strings dinâmicas
library(tidyverse)     # Conjunto de pacotes para manipulação de dados

# Bibliotecas para manipulação de bancos de dados
library(DBI)           # Interface de banco de dados
library(RSQLite)       # Conexão com SQLite
library(sqldf)        # Manipulação de dados SQL dentro do R

inputDados <- function(dados, conexao, nome_da_tabela, mes, local, sexo, raca, gdi, setor) {
  admissoes <- contador(filtragem_de_movimentacoes(dados, local, sexo, raca, gdi, setor), T)
  demissoes <- contador(filtragem_de_movimentacoes(dados, local, sexo, raca, gdi, setor), F)
  
  dbExecute(conexao, glue::glue("
    INSERT INTO {nome_da_tabela} (mes, local, sexo, raca, grau_de_instrucao, cnae, n_admissoes, n_demissoes)
    VALUES ('{mes}', '{local}', '{sexo}', '{raca}', '{gdi}', '{setor}', {admissoes}, {demissoes})
  "))
}



Input <- function(vetor,conexao_,nome){
  i <- 1
  
  while(i <= 12){
    
    dados_processados = preprocessamento(vetor[[as.character(i)]][2])
    mes_ = vetor[[as.character(i)]][1]
    
    for(local_ in local){
      for(sexo_ in sexo){
        for(raca_ in raca_cor){
          for(gdi_ in grau_de_instrucao){
            for(setor_ in setores){
              
              inputDados(dados = dados_processados, conexao = conexao_,nome_da_tabela = nome,mes = mes_,
                         local = local_,sexo = sexo_,
                         raca = raca_, gdi = gdi_, setor = setor_)
            }
          }
        }
      }
    }
    cat("O arquivo",vetor[[as.character(i)]][2],"referente ao mês de",vetor[[as.character(i)]][1],"foi executado com sucesso","\n")
    i = i + 1
    
  }
}
