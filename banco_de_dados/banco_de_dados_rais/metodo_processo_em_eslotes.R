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
local = c("", "CE", "PE")  # Local
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

# Função para processar dados por um determinado tempo e número de iterações
processando_por_tempo <- function(tempo = 10, numero_de_iteracoes = 300, vetor1 = NULL,
                                  vetor2 = NULL, vetor3 = NULL, vetor4 = NULL, vetor5 = NULL){
  i = 1  # Contador de iterações
  indice = 1  # Índice de registros
  for(v1 in vetor1){
    for(v2 in vetor2){
      for (v3 in vetor3){
        for(v4 in vetor4){
          for(v5 in vetor5){
            
            # Se o número de iterações atingir o limite, pausa o processo
            if(i == numero_de_iteracoes){
              i = 1
              Sys.sleep(tempo)  # Pausa o processo por 'tempo' segundos
            } else{
              i = i + 1
              indice = indice + 1
              cat(indice, v1, v2, v3, v4, v5, "\n")  # Exibe o progresso
            }
          }
        }
      }
    }
  }  
}

# Chamando a função para processar com parâmetros definidos
processando_por_tempo(tempo = 10, numero_de_iteracoes = 20, local, sexo, raca_cor, grau_de_instrucao, setores)

# Inserindo dados na tabela iterativamente
for(local_ in local){
  for(sexo_ in sexo){
    for(cor_ in raca_cor){
      for(gdi_ in grau_de_instrucao){
        for(setor_ in setores){
          
          # Inserção dos dados na tabela "rais"
          dbExecute(con, glue("INSERT INTO rais (ano, local, sexo, raca, grau_de_instrucao, cnae, estoque) 
                    VALUES (2022, '{local_}', '{sexo_}', 
                          '{cor_}', '{gdi_}', '{setor_}', {funcao_estoque_rais(local_, sexo_, cor_, gdi_, setor_)});"))
        }
      }
    }
  }
}
