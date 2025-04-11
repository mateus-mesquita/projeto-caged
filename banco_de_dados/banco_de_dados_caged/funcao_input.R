# inputação dos dados:
library(glue)          # Construção de strings dinâmicas
library(tidyverse)     # Conjunto de pacotes para manipulação de dados

# Bibliotecas para manipulação de bancos de dados
library(DBI)           # Interface de banco de dados
library(RSQLite)       # Conexão com SQLite
library(sqldf)        # Manipulação de dados SQL dentro do R


Input <- function(arquivos,LOCAL, SEXO, RACA, IDADE, GDI, SETOR){
  
  # definindo vetores
  # numero total de combinacoes
  comb = 12*(length(LOCAL)*length(SEXO)*length(RACA)*length(SEXO)*length(GDI)*length(SETOR))
  
  vetor_mes <- character(comb)
  vetor_local <- character(comb)
  vetor_sexo <- character(comb)
  vetor_raca <- character(comb)
  vetor_idade <- character(comb)
  vetor_gdi <- character(comb)
  vetor_setor <- character(comb)
  
  vetor_admissoes <- numeric(comb)
  vetor_demissoes <- numeric(comb)
  
  i = 1
  indice = 1
  while (i <= 12) {
    arquivo = arquivos[[as.character(i)]][2]
    mes = arquivos[[as.character(i)]][1]
    
    # carregando os dados
    DADOS = preprocessamento(arquivo)
    
    for(local_ in LOCAL){         
      for(sexo_ in SEXO){               
        for(raca_ in RACA){         
          for(idade_ in IDADE){         
            for(gdi_ in GDI){ 
              for(setor_ in SETOR){       
                
                vetor_mes[indice] = mes
                vetor_local[indice] = local_
                vetor_sexo[indice] = sexo_
                vetor_raca[indice] = raca_
                vetor_idade[indice] = idade_
                vetor_gdi[indice] = gdi_
                vetor_setor[indice] = setor_
                vetor_admissoes[indice] = contador(filtragem_de_movimentacoes(DADOS, local_, sexo_, raca_, idade_,gdi_,setor_), TRUE)
                vetor_demissoes[indice] = contador(filtragem_de_movimentacoes(DADOS, local_, sexo_, raca_, idade_,gdi_,setor_), FALSE)
                
                indice = indice + 1
              }
            }
          }
        }
      }
    }
    i = i + 1  # passa para o próximo mês
  }
  df = list(
    "mes" = vetor_mes,
    "uf" = vetor_local,
    "sexo" = vetor_sexo,
    "raca" = vetor_raca,
    "idade" = vetor_idade,
    "gdi" = vetor_gdi,
    "cnae" = vetor_setor,
    "n_admissoes" = vetor_admissoes,
    "n_demissoes" = vetor_demissoes
  )
  
  dados = data.frame(df)
  return(dados)
}

