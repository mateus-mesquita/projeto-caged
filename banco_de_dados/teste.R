# Teste de consultas

query_for<- function(local,sexo,raca,idade,gdi,setor){
  
  arquivo = RSQLite::dbConnect(SQLite(),"movimentacao.db")
  
  query = glue::glue(
    '
    SELECT admissoes FROM for_admissoes
    WHERE uf = "{local}" AND mes = "janeiro" AND
    sexo = "{sexo}" AND raçacor = "{raca}"
    AND faixa_idade = "{idade}" AND graudeinstrução = "{gdi}"
    AND seção = "{setor}";
    '
  )
  resultado = dbGetQuery(arquivo,query)
  return(resultado$admissoes)
}

for(local_ in local){
  for(sexo_ in sexo){
    for(raca_ in raca_cor){
      for(idade_ in idades){
        for(gdi_ in grau_de_instrucao){
          for(setor_ in setores){
            
            q = query_for(local_,sexo_,raca_,idade_,gdi_,setor_)
            cat(local_,sexo_,raca_,idade_,gdi_,setor_,q,'\n')
          }
        }
      }
    }
  }
}
query_for("CE","Feminino","","","","")

