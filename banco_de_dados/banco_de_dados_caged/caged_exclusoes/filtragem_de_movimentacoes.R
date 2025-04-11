filtragem_para_uma_condicao <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE, 
                                        raca = FALSE, idade = FALSE,gdi = FALSE, setor = FALSE){
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        uf == local ~ TRUE,
        sexo == sexo_ ~ TRUE,
        raçacor == raca ~ TRUE,
        faixa_idade == idade ~TRUE,
        graudeinstrução == gdi ~ TRUE,
        seção == setor ~ TRUE,
        TRUE ~ FALSE
      )
    ) %>% filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}

filtragem_para_duas_variaveis <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE,
                                          raca = FALSE, faixa = FALSE, gdi = FALSE, setor = FALSE) {
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        (uf == local & sexo == sexo_) ~ TRUE,
        (uf == local & raçacor == raca) ~ TRUE,
        (uf == local & faixa_idade == faixa) ~ TRUE,
        (uf == local & graudeinstrução == gdi) ~ TRUE,
        (uf == local & seção == setor) ~ TRUE,
        
        (sexo == sexo_ & raçacor == raca) ~ TRUE,
        (sexo == sexo_ & faixa_idade == faixa) ~ TRUE,
        (sexo == sexo_ & graudeinstrução == gdi) ~ TRUE,
        (sexo == sexo_ & seção == setor) ~ TRUE,
        
        (raçacor == raca & faixa_idade == faixa) ~ TRUE,
        (raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (raçacor == raca & seção == setor) ~ TRUE,
        
        (faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (faixa_idade == faixa & seção == setor) ~ TRUE,
        
        (graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        TRUE ~ FALSE
      )
    ) %>%
    filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}


filtragem_para_tres_variaveis <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE, 
                                          raca = FALSE, faixa = FALSE, gdi = FALSE, setor = FALSE) {
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        (uf == local & sexo == sexo_ & raçacor == raca) ~ TRUE,
        (uf == local & sexo == sexo_ & faixa_idade == faixa) ~ TRUE,
        (uf == local & sexo == sexo_ & graudeinstrução == gdi) ~ TRUE,
        (uf == local & sexo == sexo_ & seção == setor) ~ TRUE,
        
        (uf == local & raçacor == raca & faixa_idade == faixa) ~ TRUE,
        (uf == local & raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (uf == local & raçacor == raca & seção == setor) ~ TRUE,
        
        (uf == local & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (uf == local & faixa_idade == faixa & seção == setor) ~ TRUE,
        
        (uf == local & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (sexo == sexo_ & raçacor == raca & faixa_idade == faixa) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & seção == setor) ~ TRUE,
        
        (sexo == sexo_ & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (sexo == sexo_ & faixa_idade == faixa & seção == setor) ~ TRUE,
        
        (sexo == sexo_ & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (raçacor == raca & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (raçacor == raca & faixa_idade == faixa & seção == setor) ~ TRUE,
        
        (raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (faixa_idade == faixa & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        TRUE ~ FALSE
      )
    ) %>%
    filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}

filtragem_de_variaveis <- function(dados_caged = NULL, local = FALSE, sexo_ = FALSE, 
                                   raca = FALSE, faixa = FALSE, gdi = FALSE, setor = FALSE) {
  filtro <- dados_caged %>%
    mutate(
      validacao = case_when(
        (uf == local & sexo == sexo_ & raçacor == raca & faixa_idade == faixa) ~ TRUE,
        (uf == local & sexo == sexo_ & raçacor == raca & graudeinstrução == gdi) ~ TRUE,
        (uf == local & sexo == sexo_ & raçacor == raca & seção == setor) ~ TRUE,
        (uf == local & sexo == sexo_ & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (uf == local & sexo == sexo_ & faixa_idade == faixa & seção == setor) ~ TRUE,
        (uf == local & sexo == sexo_ & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (uf == local & raçacor == raca & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (uf == local & raçacor == raca & faixa_idade == faixa & seção == setor) ~ TRUE,
        (uf == local & raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (uf == local & faixa_idade == faixa & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (sexo == sexo_ & raçacor == raca & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & faixa_idade == faixa & seção == setor) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (sexo == sexo_ & faixa_idade == faixa & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (raçacor == raca & faixa_idade == faixa & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        (uf == local & sexo == sexo_ & raçacor == raca & faixa_idade == faixa) ~ TRUE,
        (uf == local & sexo == sexo_ & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (uf == local & sexo == sexo_ & faixa_idade == faixa & seção == setor) ~ TRUE,
        (uf == local & raçacor == raca & faixa_idade == faixa & seção == setor) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & faixa_idade == faixa & seção == setor) ~ TRUE,
        
        (uf == local & sexo == sexo_ & raçacor == raca & faixa_idade == faixa & graudeinstrução == gdi) ~ TRUE,
        (uf == local & sexo == sexo_ & raçacor == raca & faixa_idade == faixa & seção == setor) ~ TRUE,
        (uf == local & sexo == sexo_ & raçacor == raca & graudeinstrução == gdi & seção == setor) ~ TRUE,
        (sexo == sexo_ & raçacor == raca & faixa_idade == faixa & graudeinstrução == gdi & seção == setor) ~ TRUE,
        (uf == local & sexo == sexo_ & raçacor == raca & faixa_idade == faixa & graudeinstrução == gdi & seção == setor) ~ TRUE,
        
        TRUE ~ FALSE
      )
    ) %>%
    filter(validacao == TRUE)
  
  return(filtro$tipomovimentação)
}


filtragem_de_movimentacoes <- function(dados_caged, local, sexo, raca, idade,gdi, setor){
  if(local == "" && sexo == "" && raca == "" && idade == "" && gdi == "" && setor == ""){
    return(dados_caged$tipomovimentação)
  } 
  else{
    vetor = c(local,sexo,raca,idade,gdi,setor)
    
    i = 0
    for(vetor_ in vetor){
      if(vetor_ == ""){
        i = i + 1
      }
    }
    local_alterado = ifelse(local == "", FALSE,local)
    sexo_alterado = ifelse(sexo == "", FALSE,sexo)
    raca_alterado = ifelse(raca == "", FALSE,raca)
    idade_alterado = ifelse(idade == "",FALSE,idade)
    gdi_alterado = ifelse(gdi == "", FALSE,gdi)
    setor_alterado = ifelse(setor == "", FALSE,setor)
    
    if(i == 5){
      
      return(
        filtragem_para_uma_condicao(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                                    raca = raca_alterado, idade = idade_alterado,gdi = gdi_alterado, setor = setor_alterado))
    } 
    else if(i == 4){
      
      
      return(
        filtragem_para_duas_variaveis(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                                      raca = raca_alterado, faixa = idade_alterado,gdi = gdi_alterado, setor = setor_alterado))
    }
    else if(i == 3){
      
      return(
        filtragem_para_tres_variaveis(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                                      raca = raca_alterado, faixa = idade_alterado,gdi = gdi_alterado, setor = setor_alterado))
    }
    else{
      
      return(
        filtragem_de_variaveis(dados_caged, local = local_alterado, sexo_ = sexo_alterado,
                               raca = raca_alterado, faixa = idade_alterado,gdi = gdi_alterado, setor = setor_alterado))
    }
  }
}
