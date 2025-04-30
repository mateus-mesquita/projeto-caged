# Funções imput das tabelas combinações
# inserindo dados na tabela combinações
library(RPostgres)
library(tidyr)
# Estabelecendo a conexão com o banco de dados
con = RPostgres::dbConnect(RPostgres::Postgres(),
                           dbname = "combinacoes",      # Nome do banco de dados
                           host = "127.0.0.1",          # Endereço do host (localhost)
                           port = 5432,                 # Porta do banco de dados
                           user = "postgres",           # Usuário de acesso
                           password = "030922"        # Senha do banco de dados
)

linhas <- function(uf,municipio,sexo,raca,gdi,idade,setor){
  if(is.character(uf)){
    n = length(uf)*length(sexo)*length(raca)*length(idade)*length(gdi)*length(setor)
  } 
  else{
    n = length(municipio)*length(sexo)*length(raca)*length(idade)*length(gdi)*length(setor)
  }
}

Tabela.combinacoes <- function(conexao = FALSE, tabela = FALSE, uf_vetor = FALSE,
                               municipio_vetor = FALSE, sexo_vetor = FALSE, raca_vetor = FALSE,
                               idade_vetor = FALSE, gdi_vetor = FALSE, setor_vetor = FALSE ){
  if(is.character(uf_vetor)){
    # contagem do número de linhas:
    n = linhas(uf_vetor,FALSE,sexo_vetor,raca_vetor,gdi_vetor,idade_vetor,setor_vetor)
    # colunas:
    id = numeric(n)          # coluna id
    uf = character(n)        # coluna uf
    municipio = character(n) # coluna municipio
    sexo = character(n)      # coluna sexo
    raca = character(n)      # coluna raça
    idade = character(n)     # coluna idade
    gdi = character(n)       # coluna grau de instrução
    cnae = character(n)      # coluna cnae
    
    i = 1
    for(local_ in uf_vetor){
      for(sexo_ in sexo_vetor){
        for(raca_ in raca_vetor){
          for(idade_ in idade_vetor){
            for(gdi_ in gdi_vetor){
              for(setor_ in setor_vetor){
                id[i] = i     
                uf[i] = local_
                sexo[i] = sexo_
                raca[i] = raca_
                idade[i] = idade_
                gdi[i] = gdi_
                cnae[i] = setor_
                i = i + 1
              }
            }
          }
        }
      }
    }
    df = data.frame(id,uf,sexo,raca,idade,gdi,cnae)
    RPostgres::dbWriteTable(conexao, tabela, df, append = TRUE)
    cat("imputação da tabela",tabela,"executada")
  }
  else{
    # contagem do número de linhas:
    n = linhas(FALSE,municipio_vetor,sexo_vetor,raca_vetor,gdi_vetor,idade_vetor,setor_vetor)
    # colunas:
    id = numeric(n)          # coluna id
    uf = character(n)        # coluna uf
    municipio = character(n) # coluna municipio
    sexo = character(n)      # coluna sexo
    raca = character(n)      # coluna raça
    idade = character(n)     # coluna idade
    gdi = character(n)       # coluna grau de instrução
    cnae = character(n)      # coluna cnae
    
    i = 1
    for(local_ in municipio_vetor){
      for(sexo_ in sexo_vetor){
        for(raca_ in raca_vetor){
          for(idade_ in idade_vetor){
            for(gdi_ in gdi_vetor){
              for(setor_ in setor_vetor){
                id[i] = i     
                municipio[i] = local_
                sexo[i] = sexo_
                raca[i] = raca_
                idade[i] = idade_
                gdi[i] = gdi_
                cnae[i] = setor_
                i = i + 1
              }
            }
          }
        }
      }
    }
    df = data.frame(id,municipio,sexo,raca,idade,gdi,cnae)
    RPostgres::dbWriteTable(conexao, tabela, df, append = TRUE)
    cat("imputação da tabela",tabela,"executada")
    
  }
}

# executando os inputs
Tabela.combinacoes(conexao = con, tabela = "combinacoes_estado",uf_vetor = local,
                   municipio_vetor = FALSE, sexo_vetor = sexo, raca_vetor = raca_cor,
                   idade_vetor = idades, gdi_vetor = grau_de_instrucao, setor_vetor = setores)

Tabela.combinacoes(conexao = con, tabela = "combinacoes_municipio",uf_vetor = FALSE,
                   municipio_vetor = municipios, sexo_vetor = sexo, raca_vetor = raca_cor,
                   idade_vetor = idades, gdi_vetor = grau_de_instrucao, setor_vetor = setores)
