# Função para realizar a filtragem de movimentações com base nos parâmetros fornecidos
filtragem_de_movimentacoes <- function(conexao_, nome_da_tabela, local, sexo, raca, idade, gdi, setor) {
  
  # Verifica se nenhum filtro foi fornecido (todos os parâmetros são vazios)
  if (local == "" && sexo == "" && raca == "" && idade == "" && gdi == "" && setor == "") {
    # Se nenhum filtro foi fornecido, retorna todos os valores de 'tipomovimentação' da tabela
    query <- glue::glue("SELECT tipomovimentação FROM {nome_da_tabela}")
    return(dbGetQuery(conexao_, query))
  } 
  else {
    # Cria um vetor com todos os parâmetros de filtro fornecidos (exceto os vazios)
    vetor = c(local, sexo, raca, idade, gdi, setor)
    
    # Inicializa um contador para contar quantos filtros não foram deixados vazios
    contador = 0
    for (i in vetor) {
      if (i == "") {
        # Para cada filtro vazio, incrementa o contador
        contador = contador + 1
      }
    }
    
    # Atribui os valores fornecidos aos parâmetros correspondentes
    LOCAL = local
    SEXO  = sexo
    RACA  = raca
    IDADE = idade
    GDI   = gdi
    SETOR = setor
    
    # Chama a função de filtragem correspondente ao número de filtros aplicados
    if (contador == 1) {
      # Caso apenas um filtro tenha sido fornecido, chama a função de filtragem_1V
      return(filtragem_1V(tabela = nome_da_tabela, conexao = conexao_, 
                          local_ = LOCAL, sexo_ = SEXO, raca_ = RACA,
                          idade_ = IDADE, gdi_ = GDI, setor_ = SETOR))
    } 
    else if (contador == 2) {
      # Caso dois filtros tenham sido fornecidos, chama a função de filtragem_2V
      return(filtragem_2V(tabela = nome_da_tabela, conexao = conexao_, 
                          local_ = LOCAL, sexo_ = SEXO, raca_ = RACA,
                          idade_ = IDADE, gdi_ = GDI, setor_ = SETOR))
    } 
    else if (contador == 3) {
      # Caso três filtros tenham sido fornecidos, chama a função de filtragem_3V
      return(filtragem_3V(tabela = nome_da_tabela, conexao = conexao_, 
                          local_ = LOCAL, sexo_ = SEXO, raca_ = RACA,
                          idade_ = IDADE, gdi_ = GDI, setor_ = SETOR))
    } 
    else if (contador == 4) {
      # Caso quatro filtros tenham sido fornecidos, chama a função de filtragem_4V
      return(filtragem_4V(tabela = nome_da_tabela, conexao = conexao_, 
                          local_ = LOCAL, sexo_ = SEXO, raca_ = RACA,
                          idade_ = IDADE, gdi_ = GDI, setor_ = SETOR))
    } 
    else {
      # Caso cinco ou seis filtros tenham sido fornecidos, chama a função de filtragem_56V
      return(filtragem_56V(tabela = nome_da_tabela, conexao = conexao_, 
                           local_ = LOCAL, sexo_ = SEXO, raca_ = RACA,
                           idade_ = IDADE, gdi_ = GDI, setor_ = SETOR))
    }
  }
}
