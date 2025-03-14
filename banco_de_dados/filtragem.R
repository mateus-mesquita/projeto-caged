# testando uma nova função

contador(filtro(teste,"CE","","",""),T)
filtro = function(df,estado,sexo,cor,instrucao){
  
  # considerando o arquivo todo
  if(estado == "" & sexo == "" & cor == "" & instrucao == ""){
    return(c(df$tipomovimentação))
  }
  
  # filtragem de dados considerando apenas o estado
  else if(estado != "" & sexo == "" & cor == "" & instrucao == ""){
    dados = df %>% filter(uf == estado)
    return(c(dados$tipomovimentação))
  }
  
  # filtragen de dados considerando apenas o sexo
  else if(estado == "" & sexo != "" & cor == "" & instrucao == ""){
    dados = df %>% filter(sexo == sexo)
    return(c(dados$tipomovimentação))
  }
  
  # filtragem de dados considerando apenas a cor
  else if(estado == "" & sexo == "" & cor != "" & instrucao == ""){
    dados = df %>% filter(raçacor == cor)
    return(c(dados$tipomovimentação))
  }
  
  # filtragem de dados considerando apenas o grau de instrução
  else if(estado == "" & sexo == "" & cor == "" & instrucao != ""){
    dados = df %>% filter(graudeinstrução == instrucao)
    return(c(dados$tipomovimentação))
  }
  
  # filtragem de dados considerando apenas estado e sexo
  else if(estado != "" & sexo != "" & cor == "" & instrucao == ""){
    dados = df %>% filter(uf == estado & sexo == sexo)
    return(c(dados$tipomovimentação))
  }
  
  # filtragem de dados considerando apenas estado e cor:
  else if(estado != "" & sexo == "" & cor != "" & instrucao == ""){
    dados = df %>% filter(uf == estado & raçacor == cor)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando apenas estado e grau de instrução
  else if(estado != "" & sexo == "" & cor == "" & instrucao != ""){
    dados = df %>%filter(uf == estado & graudeinstrução==instrucao)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando apenas sexo e cor
  else if(estado == "" & sexo != "" & cor != "" & instrucao == ""){
    dados = df %>%filter(sexo == sexo & raçacor == cor)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando apenas sexo e grau de instrução
  else if(estado =="" & sexo != "" & cor =="" & instrucao != ""){
    dados = df %>%filter(sexo == sexo & graudeinstrução == instrucao)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando apenas cor e grau de instrução
  else if(estado == "" & sexo == "" & cor != "" & instrucao != ""){
    dados = df %>%filter(raçacor == cor & graudeinstrução == instrucao)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando estado, sexo e cor
  else if(estado != "" & sexo != "" & cor != "" & instrucao == ""){
    dados = df %>%filter(uf == estado & sexo == sexo & raçacor == cor)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando estado, sexo e grau de instrução
  else if(estado != "" & sexo != "" & cor == "" & instrucao != ""){
    dados = df %>%filter(uf == estado & sexo == sexo & graudeinstrução == instrucao)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando sexo, cor e grau de instrução
  else if(estado == "" & sexo != "" & cor != "" & instrucao != ""){
    dados = df %>%filter(sexo == sexo & raçacor == cor & graudeinstrução == instrucao)
    return(c(dados$tipomovimentação))
  }
  # filtragem de dados considerando estado, cor e grau de instrução
  else if(estado != "" & sexo == "" & cor != "" & instrucao != ""){
    dados = df%>%filter(uf == estado & raçacor == cor & graudeinstrução == instrucao)
    return(c(dados$tipomovimentação))
  }
  # filtrando dados considerando todas as variáveis
  else if(estado != "" & sexo != "" & cor != "" & instrucao != ""){
    dados = df %>%filter(uf == estado & sexo == sexo & raçacor == cor & graudeinstrução == instrucao)
    return(c(dados$tipomovimentação))
  }
}

local = c("","CE","PE")
sexo = c ("Masculino","Feminino")
raca_cor = c("Branca","Preta")
grau_de_instrucao = c("","ANALFABETO")

busca = c('Admissao','demissão','Admissão')
ll = preprocessamento(cageds)
contador_de_movimentacoes_c(c(dados$tipomovimentação),FALSE)

df_teste = enumerarConjuntos(vec1 = local,vec2 = sexo,vec3 = raca_cor, vec4 = grau_de_instrucao);df_teste

query_estoque('CE','','','')[[1]]

estoque = movimentacao(dados = dados_, vec1 = local, vec2 = sexo, vec3 = raca_cor, vec4 = grau_de_instrucao)

gg = cbind(df_teste,estoque)
filtro(,"CE","","","")
