# Craindo nova função de contagem
teste = c(filtragem_de_movimentacoes(con_arquivos,"cagedfor202201","","","","","MEDIO INCOMP",""))

# Nova função de busca
validar <- function(x){
  return(grepl("Admissao",x))
}

# Função final
validar.mov <- function(x){
  unname(sapply(x, validar))
}

contador_de_mov <- function(valores,admissao){
  if(admissao == TRUE){
    sum(unlist(validar.mov(valores)))
  } else{
    sum(unlist(!validar.mov(valores)))
  }
}

contador_de_mov(teste$tipomovimentação,T);contador_de_mov(teste$tipomovimentação,F)
