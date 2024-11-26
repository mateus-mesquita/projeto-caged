estoque_alterado_teste = function(ano,uf_,sexo_,raca_,grau_inst_,cnae_2_menor, cnae_2_maior,cbo) {
  estados = c('CE','PE') # lista de estados
  
  sexo_lista = c("Feminino", "Masculino", "Não informado") # sexo
  
  raca_lista = c("Branca", "Preta", "Parda", "Amarela", "Indígena", 
                 "Não informada", "Não identificado" ) # Raças
  
  grau_de_instrucao = c( "ANALFABETO", "ATE 5.A INC", "5.A CO FUND", "6.A.9.FUND",
                         "FUND COMPL", "MEDIO INCOMP", "MEDIO COMPL",
                         "SUP.INCOMP", "SUP.COMP", "MESTRADO",
                         "DOUTORADO") # níveis de escolaridades
  
  # Consulta caso todos os valores sejam verdadeiros:
  if(ano == 2022 & uf_ %in% estados & sexo_ %in% sexo_lista & raca_ %in% raca_lista
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_geral(uf = uf_,sexo = sexo_,raca = raca_,grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  
  # Consulta que retorna caso os valores estejam em branco:
  if(ano == 2022 & uf_ == '' & sexo_ == '' & raca_ == ''
     & grau_inst_ == '' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query()
    valor_ = as.numeric(valor)
    return(valor_)
  }
  
  # Consulta que retorna apenas para estados (os outros valores devem estar em branco):
  
  if(ano == 2022 & uf_ %in% estados & sexo_ == '' & raca_ == ''
     & grau_inst_ == '' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_estados(uf = uf_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna apenas paras as sexos ( os outros devem estar em branco):
  
  if(ano == 2022 & uf_ == '' & sexo_ %in% sexo_lista & raca_ == ''
     & grau_inst_ == '' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sexo(sexo = sexo_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  
  if(ano == 2022 & uf_ == '' & sexo_ %in% sexo_lista & raca_ %in% raca_lista
     & grau_inst_ == '' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sexo_raca(sexo = sexo_,raca = raca_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  
  # Consulta que retorna apenas para as raças (Os outros devem estar em branco):
  if(ano == 2022 & uf_ == '' & sexo_ == '' & raca_ %in% raca_lista
     & grau_inst_ == '' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_raca(raca = raca_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna apenas para os graus de instrução (Os outros devem estar em branco):
  if(ano == 2022 & uf_ == '' & sexo_ == '' & raca_ == ''
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_grau_inst(grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Colnsulta que retorna apenas para uf e sexo(Os outros devem estar em branco):
  if(ano == 2022 & uf_ %in% estados & sexo_ %in% sexo_lista & raca_ == ''
     & grau_inst_ =='' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_uf1(uf = uf_,sexo = sexo_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna apenas para uf e raça(Os outros devem estar em branco):
  if(ano == 2022 & uf_ %in% estados & sexo_ == '' & raca_ %in% raca_lista
     & grau_inst_ == '' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_uf_raca(uf = uf_,raca = raca_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna apenas para uf e grau de instrução(Os brancos devem estar em branco):
  if(ano == 2022 & uf_ %in% estados & sexo_ == '' & raca_== ''
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_graus_uf(uf = uf_,grau_inst= grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna para uf, sexo e raça(Os outros devem estar em branco):
  if(ano == 2022 & uf_ %in% estados & sexo_ %in% sexo_lista & raca_ %in% raca_lista
     & grau_inst_ == '' & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sem_instrucao(uf = uf_,sexo = sexo_,raca = raca_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna sexo e raça(Os outros devem estar em branco):
  if(ano == 2022 & uf_ == '' & sexo_ %in% sexo_lista & raca_ == ""
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sexo_inst(sexo = sexo_,grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna sexo e grau de instrução(Os outros devem estar em branco)
  if(ano == 2022 & uf_ == '' & sexo_ %in% sexo_lista & raca_ == ''
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sem_uf(sexo = sexo_,raca = raca_ ,grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  
  # Consulta que retorna sexo, raça e grau de instrução(Os outros devem estar em branco):
  if(ano == 2022 & uf_ == '' & sexo_ %in% sexo_lista & raca_ %in% raca_lista
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sem_uf(sexo = sexo_,raca = raca_,grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna raça e grau de instrução(Os outros devem estar em branco):
  if(ano == 2022 & uf_ == '' & sexo_ =='' & raca_ %in% raca_lista
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_raca_inst(raca = raca_,grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna uf, raça e grau de instrução(Os outros devem estar em branco):
  if(ano == 2022 & uf_ %in% estados & sexo_ =='' & raca_ %in% raca_lista
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sem_sx(uf = uf_,raca = raca_,grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  # Consulta que retorna uf, sexo e grau de instução(Os outros devem estar em branco):
  if(ano == 2022 & uf_ %in% estados & sexo_ %in% sexo_lista & raca_ == ""
     & grau_inst_ %in% grau_de_instrucao & cnae_2_maior == FALSE & cnae_2_menor == FALSE & cbo == FALSE){
    
    valor = query_sem_raca(uf = uf_,sexo = sexo_,grau_inst = grau_inst_)
    valor_ = as.numeric(valor)
    return(valor_)
  }
  
  
  
  
}

