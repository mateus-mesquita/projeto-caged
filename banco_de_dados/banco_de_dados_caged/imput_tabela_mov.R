# Carregando bibliotecas necessárias para conexões com banco de dados e uso de C++
library(glue)
library(DBI)
library(RPostgres)
library(Rcpp)

# Estabelecendo conexão com o banco de movimentações
con = RPostgres::dbConnect(RPostgres::Postgres(),
                           dbname = "movimentacoes_for", 
                           host = "127.0.0.1",
                           port = 5432,
                           user = "postgres",
                           password = "030922")

# Estabelecendo conexão com banco de arquivos
con_arquivos = RPostgres::dbConnect(RPostgres::Postgres(),
                                    dbname = "cagedfor_dados",
                                    host = "127.0.0.1",
                                    port = 5432,
                                    user = "postgres",
                                    password = "030922")

# Função que calcula o número total de combinações possíveis
linhas <- function(uf,municipio,sexo,raca,gdi,idade,setor){
  if(is.character(uf)){
    # Se for vetor de UFs, multiplica os comprimentos dos vetores
    n = length(uf)*length(sexo)*length(raca)*length(idade)*length(gdi)*length(setor)
  } else {
    # Caso contrário, considera o vetor de municípios
    n = length(municipio)*length(sexo)*length(raca)*length(idade)*length(gdi)*length(setor)
  }
}

# Função principal de imputação de movimentações
Input.mov <- function(conexao,conexao_arquivo,arquivo,tabela,mes_,uf_vetor,municipio_vetor,
                      sexo_vetor,raca_vetor,idade_vetor,gdi_vetor,setor_vetor){
  
  # Se estamos lidando com UFs (e não municípios)
  if(is.character(uf_vetor)){
    n = linhas(uf_vetor,F,sexo_vetor,raca_vetor,idade_vetor,gdi_vetor,setor_vetor)
    
    # Inicialização dos vetores de saída
    id = numeric(n)
    mes = character(n)
    admissoes = numeric(n)
    demissoes = numeric(n)
    
    i = 1
    # Loop aninhado para gerar todas as combinações
    for(local_ in uf_vetor){
      for(sexo_ in sexo_vetor){
        for(raca_ in raca_vetor){
          for(idade_ in idade_vetor){
            for(gdi_ in gdi_vetor){
              for(setor_ in setor_vetor){
                # Filtra os dados conforme os critérios
                mov = filtragem_de_movimentacoes(conexao_arquivo,arquivo,local_,sexo_,raca_,
                                                 gdi_,idade_,setor_)
                # Preenche os vetores
                id[i] = i
                mes[i] = mes_
                admissoes[i] = contador_de_mov(mov$tipomovimentação,T)
                demissoes[i] = contador_de_mov(mov$tipomovimentação,F)
                
                # Feedback no console
                cat(i,local_,sexo_,raca_,idade_,gdi_,setor_,contador_de_mov(mov$tipomovimentação,T),
                    contador_de_mov(mov$tipomovimentação,F),"\n")
                i = i + 1
              }
            }
          }
        }
      }
    }
    df = data.frame(id,mes,admissoes,demissoes)
    return(df)
    
  } else { # Se for por município
    n = linhas(F,municipio_vetor,sexo_vetor,raca_vetor,idade_vetor,gdi_vetor,setor_vetor)
    
    id = numeric(n)
    mes = character(n)
    admissoes = numeric(n)
    demissoes = numeric(n)
    
    i = 1
    for(local_ in municipio_vetor){
      for(sexo_ in sexo_vetor){
        for(raca_ in raca_vetor){
          for(idade_ in idade_vetor){
            for(gdi_ in gdi_vetor){
              for(setor_ in setor_vetor){
                mov = filtragem_de_movimentacoes(conexao_arquivo,arquivo,local_,sexo_,raca_,
                                                 gdi_,idade_,setor_)
                id[i] = i
                mes[i] = mes_
                admissoes[i] = contador_de_mov(mov$tipomovimentação,T)
                demissoes[i] = contador_de_mov(mov$tipomovimentação,F)
                
                cat(i,local_,sexo_,raca_,idade_,gdi_,setor_,
                    contador_de_mov(mov$tipomovimentação,T),
                    contador_de_mov(mov$tipomovimentação,F))
                i = i + 1
              }
            }
          }
        }
      }
    }
  }
  
  # Retorna o data frame final
  df = data.frame(id,mes,admissoes,demissoes)
  return(df)
}

# Teste da função com parâmetros definidos previamente (como local, sexo, etc.)
Input.mov(conexao = con, conexao_arquivo = con_arquivos,arquivo = "cagedfor202201",
          tabela = "estado_movfor_202201",mes_ = "janeiro",uf_vetor = local, municipio_vetor = FALSE,
          sexo_vetor = sexo, raca_vetor = raca_cor, idade_vetor = idades, 
          gdi_vetor = grau_de_instrucao, setor_vetor = setores)


