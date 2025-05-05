# Executando a contagem de estoque para os arquivos

input.dados_mov <- function(lista,uf_vetor,sexo_vetor,raca_vetor,idades_vetor,
                            gdi_vetor,setor_vetor){
  i = 1
  while (i <= 12) {
    dados = preprocessamento(lista[[as.character(i)]][1])
    
    # vetores 
    id = numeric(n)
    admisssoes = numeric(n)
    demissoes = numeric(n)
    
    indice = 1
    # iterações
    for(local_ in uf_vetor){
      for(sexo_ in sexo_vetor){
        for(raca_ in raca_vetor){
          for(idade_ in idades_vetor){
            for(gdi_ in gdi_vetor){
              for(setor_ in setor_vetor){
                
                id[indice] = indice
                admissoes[indice] = ...
                demissoes[indice] = ...
                indice = indice + 1
              }
            }
          }
        }
      }
    }
    df = data.frame(id,admissoes,demissoes)
    # preencher tabela
    i = i + 1
    
  }
}