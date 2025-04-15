

teste = tidyr::expand_grid(local,sexo,raca_cor,idades,grau_de_instrucao,setores)
i = 1
system.time(
    while(i <= length(teste$local)){
    ts = filtragem_de_movimentacoes(con,"cagedfor202201",teste$local[i],teste$sexo[i],teste$raca_cor[i],teste$idades[i],teste$grau_de_instrucao[i],
                                    teste$setores[i])
    
    cat(i,teste$local[i],teste$sexo[i],teste$raca_cor[i],teste$idades[i],teste$grau_de_instrucao[i],
        teste$setores[i],contador(ts$tipomovimentação,TRUE),contador(ts$tipomovimentação,FALSE),"\n")
    i = i + 1
    }
)
