# Instalação das bibliotecas necessárias
library(basedosdados)  # Interface para acessar bases de dados públicas
library(bigrquery)      # Conexão com BigQuery
library(glue)          # Construção de strings dinâmicas
library(tidyverse)     # Conjunto de pacotes para manipulação de dados

# Bibliotecas para manipulação de bancos de dados
library(DBI)           # Interface de banco de dados
library(RSQLite)       # Conexão com SQLite
library(sqldf)         # Manipulação de dados SQL dentro do R

# Criar ou conectar ao banco de dados SQLite (se não existir, será criado)
con <- dbConnect(RSQLite::SQLite(), "Rais_dados.db")

# Criando a tabela "rais" com os campos especificados
dbExecute(con, "CREATE TABLE rais(
                  ano INTEGER,
                  local TEXT,
                  sexo TEXT,
                  raca TEXT,
                  grau_de_instrucao TEXT,
                  cnae TEXT,
                  estoque INTEGER
                );")

# Definição das categorias para preenchimento da tabela
local = c("", "CE", "PE")  # Local (diversos estados)
sexo = c("", "Feminino", "Masculino", "Não informado")  # Sexo
raca_cor = c("", "Branca", "Preta", "Parda", "Amarela", "Indígena", "Não informada", "Não identificada")  # Raça ou cor
grau_de_instrucao = c("", "ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6.A.9.FUND", 
                      "FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL", "SUP.INCOMP", 
                      "SUP.COMP", "MESTRADO", "DOUTORADO")  # Grau de instrução
setores <- c("", 
             "Agricultura, Pecuária, Produção Florestal, Pesca e Aquicultura",
             "Indústrias Extrativas",
             "Indústrias de Transformação",
             "Eletricidade e Gás",
             "Água, Esgoto, Atividades de Gestão de Resíduos e Descontaminação",
             "Construção",
             "Comércio; Reparação de Veículos Automotores e Motocicletas",
             "Transporte, Armazenagem e Correio",
             "Alojamento e Alimentação",
             "Informação e Comunicação",
             "Atividades Financeiras, de Seguros e Serviços Relacionados",
             "Atividades Imobiliárias",
             "Atividades Profissionais, Científicas e Técnicas",
             "Atividades Administrativas e Serviços Complementares",
             "Administração Pública, Defesa e Seguridade Social",
             "Educação",
             "Saúde Humana e Serviços Sociais",
             "Artes, Cultura, Esporte e Recreação",
             "Outras Atividades de Serviços",
             "Serviços Domésticos",
             "Organismos Internacionais e Outras Instituições Extraterritoriais",
             "Não identificado"
)

# Inicialização do índice e criação de uma lista para armazenar as iterações
indice = 122  # Começa a partir do índice 122
lista_de_iteracoes = list()  # Lista para armazenar as combinações de variáveis

# Loop para gerar todas as combinações possíveis dos vetores e armazená-las na lista
for(local_ in local){
  for(sexo_ in sexo){
    for(cor_ in raca_cor){
      for(gdi_ in grau_de_instrucao){
        for(setor_ in setores){
          lista_de_iteracoes[[indice]] = c(local_, sexo_, cor_, gdi_, setor_)  # Armazena a combinação na lista
          indice = indice + 1  # Incrementa o índice
        }
      }
    }
  }
}

# Loop para imprimir todas as combinações armazenadas na lista
for(i in indice:length(lista_de_iteracoes)){
  cat(i, lista_de_iteracoes[[i]][[1]], lista_de_iteracoes[[i]][[2]],
      lista_de_iteracoes[[i]][[3]], lista_de_iteracoes[[i]][[4]], lista_de_iteracoes[[i]][[5]], "\n")
}


