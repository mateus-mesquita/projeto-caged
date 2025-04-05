filtragem_para_uma_condicao <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE, 
                                        raca = FALSE, gdi = FALSE, setor = FALSE){
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        uf == local ~ TRUE,
        sexo == sexo_ ~ TRUE,
        raçacor == raca ~ TRUE,
        graudeinstrução == gdi ~ TRUE,
        seção == setor ~ TRUE,
        TRUE ~ FALSE
      )
    ) %>% filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}

filtragem_para_duas_variaveis <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE,
                                          raca = FALSE, gdi = FALSE, setor = FALSE){
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        (uf == local & sexo == sexo_) ~ TRUE,
        (uf == local & raçacor == raca) ~ TRUE,
        (uf == local & graudeinstrução == gdi) ~ TRUE,
        (uf == local & seção == setor) ~ TRUE,
        (sexo == sexo_ & raçacor == raca) ~ TRUE,
        (sexo == sexo_ & graudeinstrução == gdi) ~ TRUE,
        (sexo == sexo_ & seção == setor) ~ TRUE,
        (raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (raçacor == raca & seção == setor) ~ TRUE,
        (graudeinstrução == gdi & seção == setor) ~ TRUE,
        TRUE ~ FALSE
      )
    ) %>% filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}

filtragem_para_tres_variaveis <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE, 
                                          raca = FALSE, gdi = FALSE, setor = FALSE){
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        (uf == local & sexo == sexo_ & raçacor == raca) ~ TRUE,
        (uf == local & sexo == sexo_ & graudeinstrução == gdi) ~ TRUE,
        (uf == local & sexo == sexo_ & seção == setor) ~ TRUE,
        (uf == local & raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (uf == local & raçacor == raca & seção == setor) ~ TRUE,
        (uf == local & graudeinstrução == gdi & seção == setor) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & seção == setor) ~ TRUE,
        (sexo == sexo_ & graudeinstrução == gdi & seção == setor) ~ TRUE,
        (raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        TRUE ~ FALSE
      )
    ) %>% filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}

filtragem_de_variaveis <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE, 
                                   raca = FALSE, gdi = FALSE, setor = FALSE){
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        (uf == local & sexo == sexo_ & raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (uf == local & sexo == sexo_ & raçacor == raca & seção == setor) ~ TRUE,
        (uf == local & sexo == sexo_ & graudeinstrução == gdi & seção == setor) ~ TRUE,
        (uf == local & raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        (uf == local & sexo == sexo_ & raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        TRUE ~ FALSE
      )
    ) %>% filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}

filtragem_de_movimentacoes <- function(dados_caged, local, sexo, raca, gdi, setor){
  if(local == "" && sexo == "" && raca == "" && gdi == "" && setor == ""){
    return(dados_caged$tipomovimentação)
  } 
  else{
    vetor = c(local,sexo,raca,gdi,setor)
    
    i = 0
    for(vetor_ in vetor){
      if(vetor_ == ""){
        i = i + 1
      }
    }
    local_alterado = ifelse(local == "", FALSE,local)
    sexo_alterado = ifelse(sexo == "", FALSE,sexo)
    raca_alterado = ifelse(raca == "", FALSE,raca)
    gdi_alterado = ifelse(gdi == "", FALSE,gdi)
    setor_alterado = ifelse(setor == "", FALSE,setor)
    
    if(i == 4){
      
      return(
        filtragem_para_uma_condicao(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                                    raca = raca_alterado, gdi = gdi_alterado, setor = setor_alterado))
    } 
    else if(i == 3){
      
      
      return(
        filtragem_para_duas_variaveis(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                                      raca = raca_alterado, gdi = gdi_alterado, setor = setor_alterado))
    }
    else if(i == 2){
      
      return(
        filtragem_para_tres_variaveis(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                                      raca = raca_alterado, gdi = gdi_alterado, setor = setor_alterado))
    }
    else{
      
      return(
        filtragem_de_variaveis(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                               raca = raca_alterado, gdi = gdi_alterado, setor = setor_alterado))
    }
  }
}

cageds = "CAGEDEXC202201.txt"
dados = preprocessamento(cageds)
# testando as filtragem e as contagens de movimentações
for(local_ in local){
  for(sexo_ in Sexo){
    for(raca_ in raca_cor){
      for(gdi_ in grau_de_instrucao){
        for(setor_ in setores){
          
          cat(local_,sexo_,raca_,gdi_,setor_,
              contador(filtragem_de_movimentacoes(dados,local_,sexo_,raca_,gdi_,setor_),T),
              contador(filtragem_de_movimentacoes(dados,local_,sexo_,raca_,gdi_,setor_),F),"\n")
        }
      }
    }
  }
}

a = dados %>% filter(sexo == "Feminino" & raçacor == "Branca" & graudeinstrução == "SUP.COMP" & seção == "Saúde Humana e Serviços Sociais")
contador(a$tipomovimentação,F)

contador(filtragem_de_variaveis(dados, local = "PE", sexo = "Masculino", gdi = "DOUTORADO", setor = 'Alojamento e Alimentação'),F)
