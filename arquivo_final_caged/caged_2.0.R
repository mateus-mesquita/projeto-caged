library(dplyr)
library(survey)
library(readr)
library(basedosdados)
library(glue)
library(tidyverse)
library(curl)
library(bigrquery)

# Banco de dados:
library(DBI)
library(RSQLite)
library(sqldf)

options(InDec=",", OutDec= ",")

imprimir_variaveis_caged <- function(cagedN)
{
  tamanho <- nrow(cagedN)
  salario <- mean(as.numeric(sub(",", ".", cagedN$salário, fixed = TRUE)), na.rm = TRUE)
  salario_fixo <- mean(as.numeric(sub(",", ".", cagedN$valorsaláriofixo, fixed = TRUE)), na.rm = TRUE)
  idade <- mean(cagedN$idade, na.rm = TRUE)
  horas_contratuais <- mean(as.numeric(sub(",", ".", cagedN$horascontratuais, fixed = TRUE)), na.rm = TRUE)
  
  return (paste(format(tamanho, nsmall=0), ";",
                format(round(salario, 2), nsmall=2), ";",
                format(round(salario_fixo, 2), nsmall=2), ";",
                format(round(idade, 0), nsmall=0), ";",
                format(round(horas_contratuais, 0), nsmall=0), ";"
  ))
}

enumerar_conjuntos_anterior <- function(cagedN)
{
  
  local = c("", "CE", "PE")
  sexo = c ("", "Feminino", "Masculino", "Não informado")
  raca_cor = c("", "Branca", "Preta", "Parda", "Amarela", "Indígena", "Não identificado" )
  grau_de_instrucao = c("", "ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6.A.9.FUND",
                        "FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",
                        "SUP.INCOMP", "SUP.COMP", "MESTRADO",
                        "DOUTORADO")
  tipo_de_movimentacao = c("", "Admissão por primeiro emprego", "Admissão por reemprego",
                           "Admissão por contrato trabalho prazo determinado", 
                           "Desligamento por demissão sem justa causa",
                           "Desligamento por demissão com justa causa",
                           "Culpa Recíproca", "Admissão por reintegração",
                           "Desligamento a pedido", "Término contrato trabalho prazo determinado",
                           "Desligamento por Término de contrato", "Desligamento por aposentadoria",
                           "Desligamento por morte", "Admissão por transferência",
                           "Desligamento por transferência", "Desligamento por Acordo entre empregado e empregador",
                           "Admissão de Tipo Ignorado", "Desligamento de Tipo Ignorado", "Não Identificado")
  categoria = c("", 
                "Empregado - Geral, inclusive o empregado público da administração direta ou indireta contratado pela CLT",
                "Empregado - Trabalhador rural por pequeno prazo da Lei 11.718/2008",
                "Empregado - Aprendiz", "Empregado - Doméstico",
                "Empregado - Contrato a termo firmado nos termos da Lei 9.601/1998",
                "Trabalhador temporário - Contrato nos termos da Lei 6.019/1974",
                "Empregado - Contrato de trabalho Verde e Amarelo - sem acordo para antecipação mensal da multa rescisória do FGTS",
                "Empregado - Contrato de trabalho Verde e Amarelo - com acordo para antecipação mensal da multa rescisória do FGTS",
                "Empregado - Contrato de trabalho intermitente", "Não Identificado")
  cat( paste( "Fonte;", "Local;", "Sexo;", "Raça-cor;", "Grau de instrução;",
              "Tipo de movimentação;" ,"Categoria;" ,"Amostra;", 
              "Salário;", "Salário Fixo;","Idade;", "Horas Contratuais;",'estoque; \n'),
       file = "resultados_caged.csv", 
       append = FALSE)
  
  
  for (cagedf in cageds)
  {
    cagedc <- preprocessamento(cagedf)
    
    for (local_ in local)
    {
      # Local (estado ou Brasil)
      cagedsubl <- subset(cagedc,  ( (local_== "") | (cagedc$uf == local_) ) )
      
      for (sexo_ in sexo)
      {
        # Sexo (homem ou mulher)
        cagedsubs <- subset(cagedsubl,  ( (sexo_ == "") | (cagedsubl$sexo == sexo_ ) ) ) 
        for (raca_cor_ in raca_cor)
        {
          # Raça/Cor
          cagedsubrc <- subset(cagedsubs,  ( (raca_cor_ == "") | (cagedsubs$raçacor == raca_cor_ ) ) ) 
          for (gdi_ in grau_de_instrucao)
          {
            
            # Grau de instrução
            cagedsubgdi <- subset(cagedsubrc,  ( (gdi_ == "") | (cagedsubrc$graudeinstrução == gdi_ ) ) ) 
            for (tmovi_ in  tipo_de_movimentacao)
            {
              
              # Tipo de Movimentação
              cagedsubtmovi <- subset(cagedsubgdi, ( (tmovi_ == "") | (cagedsubgdi$tipomovimentação == tmovi_) ) )
              for (categoria_ in categoria)
              {
            
              # Categoria
              cagedsubct <- subset(cagedsubtmovi, ( (categoria_ == "") | (cagedsubtmovi$categoria == categoria_ ) ) )
              
              resultado_estoque <- estoque_alterado_teste(ano = 2022, raca = raca_cor_, sexo = sexo_, grau_inst = gdi_, uf = local_, cnae_2_menor = FALSE, cnae_2_maior = FALSE, cbo = FALSE)
              
          
               cat( paste (cagedf, ";", local_, ";", sexo_, ";", raca_cor_, ";", gdi_, ";", tmovi_, ";", categoria_, ";" , 
                            imprimir_variaveis_caged(cagedsubct),resultado_estoque,"\n" ),
                     file = "resultados_caged.csv",
                     append = TRUE)
                
              
            
              }
            }  
          }
        }
      }
    }
  }
}


enumerar_conjuntos <- function(cagedN)
{
  
  local = c("", "CE", "PE")
  sexo = c ("", "Feminino", "Masculino")
  
  raca_cor = c("", "Branca", "Preta", "Parda", "Amarela", "Indígena", "Não identificado" )
  
  grau_de_instrucao = c("", "ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6.A.9.FUND",
                        "FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",
                        "SUP.INCOMP", "SUP.COMP", "MESTRADO",
                        "DOUTORADO")
 

  cat( paste("Local;", "Sexo;", "Raça-cor;", "Grau de instrução;",'estoque;','\n'),
       file = "resultados_caged.csv", 
       append = FALSE)
  
  
  for (cagedf in cageds)
  {
    cagedc <- preprocessamento(cagedf)
    
    for (local_ in local)
    {
      # Local (estado ou Brasil)
      cagedsubl <- subset(cagedc,  ( (local_== "") | (cagedc$uf == local_) ) )
      
      for (sexo_ in sexo)
      {
        # Sexo (homem ou mulher)
        cagedsubs <- subset(cagedsubl,  ( (sexo_ == "") | (cagedsubl$sexo == sexo_ ) ) ) 
        for (raca_cor_ in raca_cor)
        {
          # Raça/Cor
          cagedsubrc <- subset(cagedsubs,  ( (raca_cor_ == "") | (cagedsubs$raçacor == raca_cor_ ) ) ) 
          for (gdi_ in grau_de_instrucao)
          {
            
            # Grau de instrução
            cagedsubgdi <- subset(cagedsubrc,  ( (gdi_ == "") | (cagedsubrc$graudeinstrução == gdi_ ) ) ) 
            
            x = estoque_alterado_teste(ano = 2022, raca = raca_cor_,sexo = sexo_,grau_inst = gdi_,uf = local_,
                                         cnae_2_menor = FALSE,cnae_2_maior = FALSE,cbo = FALSE)
        
            cat( paste (local_, ";", sexo_, ";", raca_cor_, ";", gdi_, ";",x,'\n' ),
                 file = "resultados_caged.csv",
                 append = TRUE)
            
            
          }
        }
      }
    }
  }
}

# id do projeto
id_project= "plucky-pointer-433718-n5"

# logar o email para realizar as consultas
bq_auth()
cageds <- c("arquivo")

enumerar_conjuntos(cageds)
