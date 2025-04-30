# Funções de imputações nas tabelas movimentações
library(glue)
library(DBI)
library(RPostgres)

# liberando funções em c++:
library(Rcpp)

con = RPostgres::dbConnect(RPostgres::Postgres(),
                           dbname = "movimentacoes_for",      # Nome do banco de dados
                           host = "127.0.0.1",          # Endereço do host (localhost)
                           port = 5432,                 # Porta do banco de dados
                           user = "postgres",           # Usuário de acesso
                           password = "030922"        # Senha do banco de dados
)


con_arquivos = RPostgres::dbConnect(RPostgres::Postgres(),
                                    dbname = "cagedfor_dados",      # Nome do banco de dados
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


Rcpp::sourceCpp("panilha_caged_final.cpp")
Input.mov <- function(conexao,conexao_arquivo,arquivo,tabela,mes_,uf_vetor,municipio_vetor,sexo_vetor,raca_vetor,
                      idade_vetor,gdi_vetor,setor_vetor){

  if(is.character(uf_vetor)){
    n = linhas(uf_vetor,F,sexo_vetor,raca_vetor,idade_vetor,gdi_vetor,setor_vetor)
    id = numeric(n)
    mes = character(n)
    admissoes = numeric(n)
    demissoes = numeric(n)
    
    i = 1
    for(local_ in uf_vetor){
      for(sexo_ in sexo_vetor){
        for(raca_ in raca_vetor){
          for(idade_ in idade_vetor){
            for(gdi_ in gdi_vetor){
              for(setor_ in setor_vetor){
                
                id[i] = i
                mes[i] = mes_
                admissoes[i] = contador(c(filtragem_de_movimentacoes(conexao_arquivos,arquivo,local_,sexo_,raca_,idade_,gdi_,
                                                                   setor_)),TRUE)
                demissoes[i] = contador(c(filtragem_de_movimentacoes(conexao_arquivos,arquivo,local_,sexo_,raca_,idade_,gdi_,
                                                                   setor_)),FALSE)
                i = i + 1
                
              }
            }
          }
        }
      }
    }
   
  }
  else{
    n = linhas(F,municipio_vetor,sexo_vetor,raca_vetor,idade_vetor,gdi_vetor,setor_vetor)
    id = numeric(n)
    mes = character(n)
    admissoes = numeric(n)
    demissoes = numeric(n)
    
    i = 1
    for(local_ in uf_vetor){
      for(sexo_ in sexo_vetor){
        for(raca_ in raca_vetor){
          for(idade_ in idade_vetor){
            for(gdi_ in gdi_vetor){
              for(setor_ in setor_vetor){
                
                id[i] = i
                mes[i] = mes_
                admissoes[i] = contador(filtragem_de_movimentacoes(conexao_arquivos,arquivo,local_,sexo_,raca_,idade_,gdi_,
                                                                   setor_),TRUE)
                demissoes[i] = contador(filtragem_de_movimentacoes(conexao_arquivos,arquivo,local_,sexo_,raca_,idade_,gdi_,
                                                                   setor_),FALSE)
                i = i + 1
              }
            }
          }
        }
      }
    }
  }
  df = data.frame(id,mes,admissoes,demissoes)
  dbWriteTable(con,tabela,df,append = TRUE)
}


# testando função
Input.mov(conexao = con, conexao_arquivo = con_arquivos,arquivo = "cagedfor202201",
          tabela = "estado_movfor_202201",mes_ = "janeiro",uf_vetor = local, municipio_vetor = FALSE,
          sexo_vetor = sexo, raca_vetor = raca_cor, idade_vetor = idades, gdi_vetor = grau_de_instrucao,
          setor_vetor = setores)

 is.character(local)
