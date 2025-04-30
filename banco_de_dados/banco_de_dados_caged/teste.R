# Craindo nova função de contagem
teste = c(filtragem_de_movimentacoes(con_arquivos,"cagedfor202201","","","","","",""))

busca.r <- function(x){
  if('Admissao' %in% x){
    return(1)
  }
  else{
    return(0)
  }
}

unname(sapply(teste$tipomovimentação, busca.r))

