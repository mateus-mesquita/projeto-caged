# Instalação das bibliotecas necessárias
library(basedosdados)  # Interface para acessar bases de dados públicas
library(bigrquery)      # Conexão com BigQuery
library(glue)          # Construção de strings dinâmicas
library(tidyverse)     # Conjunto de pacotes para manipulação de dados

# Bibliotecas para manipulação de bancos de dados
library(DBI)           # Interface de banco de dados
library(RSQLite)       # Conexão com SQLite
library(sqldf)        # Manipulação de dados SQL dentro do R

# Criar ou conectar ao banco de dados SQLite (se não existir, será criado)
con <- dbConnect(RSQLite::SQLite(), "dados_rais.db")

# Criando a tabela "rais" com os campos especificados
dbExecute(con, "CREATE TABLE rais_estado(
                  ano INTEGER,
                  uf TEXT,
                  sexo  TEXT,
                  raca  TEXT,
                  idade TEXT,
                  grau_de_instrucao TEXT,
                  cnae TEXT,
                  estoque INTEGER
                );")

# Criando função checkpoint e processamento em eslotes

Iterador <- function(local_vetor, sexo_vetor, raca_vetor, idade_vetor, gdi_vetor,setor_vetor){
  lista = list()
  
  i = 1
  for(local_ in local_vetor){
    for(sexo_ in sexo_vetor){
      for(raca_ in raca_cor){
        for(idade_ in idade_vetor){
          for(gdi_ in gdi_vetor){
            for(setor_ in setor_vetor){
              
              lista[[i]] <- c(local_,sexo_,raca_,idade_,gdi_,setor_)
              i = i+1
            }
          }
        }
      }
    }
  }
  return(lista)
}

# lista de iterações
lista_iteracoes = Iterador(local,sexo,raca,idades,grau_de_instrucao,setores)

input.rais <- function(tabela,lista,checkpoint = FALSE,tempo = 2,ano){
  if(checkpoint == FALSE){
    i = 1
    while(i <= length(lista)){
      
      if(i %% 10 == 0){
        Sys.sleep(tempo)
      }
      
      if(lista[[i]][1]=="" & lista[[i]][2] == "" & lista[[i]][3] == "" & lista[[i]][4] == "" & lista[[i]][5] == "" & lista[[i]][6] == ""){
        dbExecute(con,
                  glue('INSERT INTO "{tabela}"(ano,uf,sexo,raca,idade,grau_de_instrucao,cnae,estoque)
                       VALUES 
                       ({ano},"{lista[[i]][1]}","{lista[[i]][2]}","{lista[[i]][3]}","{lista[[i]][4]}","{lista[[i]][5]}","{lista[[i]][6]}",
                     {contagem_arquivo({ano})});'))
        
        cat(i,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6],
            funcao_estoque(ano,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6]),"\n")
        i = i + 1
      }
      
      else{
      dbExecute(con,
                glue('INSERT INTO "{tabela}"(ano,uf,sexo,raca,idade,grau_de_instrucao,cnae,estoque)
                       VALUES 
                       ({ano},"{lista[[i]][1]}","{lista[[i]][2]}","{lista[[i]][3]}","{lista[[i]][4]}","{lista[[i]][5]}","{lista[[i]][6]}",
                     {funcao_estoque(ano,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6])});'))
      
      cat(i,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6],
          funcao_estoque(ano,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6]),"\n")
      i = i + 1
      }
    }
  }
    else{
      i = checkpoint
      while(i <= length(lista)){
      if(i %% 10 == 0){
        Sys.sleep(tempo)
      }
      
      if(lista[[i]][1]=="" & lista[[i]][2] == "" & lista[[i]][3] == "" & lista[[i]][4] == "" & lista[[i]][5] == "" & lista[[i]][6] == ""){
        dbExecute(con,
                  glue('INSERT INTO "{tabela}"(ano,uf,sexo,raca,idade,grau_de_instrucao,cnae,estoque)
                       VALUES 
                       ({ano},"{lista[[i]][1]}","{lista[[i]][2]}","{lista[[i]][3]}","{lista[[i]][4]}","{lista[[i]][5]}","{lista[[i]][6]}",
                     {contagem_arquivo({ano})});'))
        
        cat(i,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6],
            funcao_estoque(ano,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6]),"\n")
        i = i + 1
      }
      
      else{
        dbExecute(con,
                  glue('INSERT INTO "{tabela}"(ano,uf,sexo,raca,idade,grau_de_instrucao,cnae,estoque)
                       VALUES 
                       ({ano},"{lista[[i]][1]}","{lista[[i]][2]}","{lista[[i]][3]}","{lista[[i]][4]}","{lista[[i]][5]}","{lista[[i]][6]}",
                     {funcao_estoque(ano,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6])});'))
        
        cat(i,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6],
            funcao_estoque(ano,lista[[i]][1],lista[[i]][2],lista[[i]][3],lista[[i]][4],lista[[i]][5],lista[[i]][6]),"\n")
        i = i + 1
      }
    }
  }
}
input.rais("rais_estado",lista_iteracoes,13,4,ano = 2022)
  

