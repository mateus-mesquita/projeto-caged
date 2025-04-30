library(glue)

# Função para filtragem de registros com 1 variável
filtragem_1V = function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_) {
  
  # Criação da query SQL com CTE (Common Table Expression)
  query <- glue::glue("
    WITH filtragem AS (
    SELECT *,
        CASE
            WHEN uf = '{local_}' THEN TRUE
            WHEN sexo = '{sexo_}' THEN TRUE
            WHEN raçacor = '{raca_}' THEN TRUE
            WHEN faixa_idade = '{idade_}' THEN TRUE
            WHEN graudeinstrução = '{gdi_}' THEN TRUE
            WHEN seção = '{setor_}' THEN TRUE
            ELSE FALSE
        END AS validacao
    FROM {tabela}
)

SELECT tipomovimentação 
FROM filtragem
WHERE validacao = TRUE;
  ")

# Executa a query no banco de dados e retorna o resultado
return(dbGetQuery(conexao, query))
}

filtragem_2V <- function(conexao,tabela, local_, sexo_, raca_, idade_, gdi_, setor_) {
  query <- glue::glue(
    "
WITH filtragem AS (
  SELECT *,
    CASE 
        WHEN (uf = '{local_}' AND sexo = '{sexo_}') THEN TRUE
        WHEN (uf = '{local_}' AND raçacor = '{raca_}') THEN TRUE
        WHEN (uf = '{local_}' AND faixa_idade = '{idade_}') THEN TRUE
        WHEN (uf = '{local_}' AND graudeinstrução = '{gdi_}') THEN TRUE
        WHEN (uf = '{local_}' AND seção = '{setor_}') THEN TRUE

        WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}') THEN TRUE
        WHEN (sexo = '{sexo_}' AND faixa_idade = '{idade_}') THEN TRUE
        WHEN (sexo = '{sexo_}' AND graudeinstrução = '{gdi_}') THEN TRUE
        WHEN (sexo = '{sexo_}' AND seção = '{setor_}') THEN TRUE

        WHEN (raçacor = '{raca_}' AND faixa_idade = '{idade_}') THEN TRUE
        WHEN (raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') THEN TRUE
        WHEN (raçacor = '{raca_}' AND seção = '{setor_}') THEN TRUE

        WHEN (faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
        WHEN (faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE

        WHEN (graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE

        ELSE FALSE
    END AS validacao
  FROM {tabela}
) 
SELECT tipomovimentação
FROM filtragem
WHERE validacao = TRUE;
"
  )
  
  return(dbGetQuery(conexao, query))
}

# Função para filtragem de registros com 3 variáveis
filtragem_3V = function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_) {
  
  # Criação da query SQL com CTE (Common Table Expression)
  query <- glue::glue("
    WITH filtragem AS (
    SELECT *,
        CASE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}') THEN TRUE
            WHEN (uf = '{local_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (uf = '{local_}' AND raçacor = '{raca_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (uf = '{local_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}' AND seção = '{setor_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE
            WHEN (raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            ELSE FALSE
        END AS validacao
    FROM {tabela}
)
SELECT tipomovimentação
FROM filtragem
WHERE validacao = TRUE;
  ")

# Executa a query no banco de dados e retorna o resultado
return(dbGetQuery(conexao, query))
}

# Função para filtragem de registros com 4 variáveis
filtragem_4V = function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_) {
  
  # Criação da query SQL com CTE (Common Table Expression)
  query <- glue::glue(
    "
    WITH filtragem AS (
    SELECT *,
        CASE
            -- Combinações de 4 variáveis
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (uf = '{local_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
            WHEN (raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE

            ELSE FALSE
        END AS validacao
      FROM {tabela}
)
SELECT tipomovimentação
FROM filtragem
WHERE validacao = TRUE;
    "
  )

# Executa a query no banco de dados e retorna o resultado
return(dbGetQuery(conexao, query))
}

# Função de filtragem para combinações de 5 e 6 variáveis
filtragem_56V <- function(tabela, conexao, local_, sexo_, raca_, idade_, gdi_, setor_) {
  
  # Criação da query SQL com CTE (Common Table Expression)
  query <- glue("
    WITH filtragem AS (
        SELECT *,
            CASE
                -- Combinações de 5 variáveis
                WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}') THEN TRUE
                WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND seção = '{setor_}') THEN TRUE
                WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
                WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
                WHEN (uf = '{local_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE
                WHEN (sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE

                -- Combinação com 6 variáveis
                WHEN (uf = '{local_}' AND sexo = '{sexo_}' AND raçacor = '{raca_}' AND faixa_idade = '{idade_}' AND graudeinstrução = '{gdi_}' AND seção = '{setor_}') THEN TRUE

                ELSE FALSE
            END AS validacao
        FROM {tabela}
    )
    SELECT tipomovimentação
    FROM filtragem
    WHERE validacao = TRUE;
  ")
  
  # Executa a query no banco de dados e retorna o resultado
  dbGetQuery(conexao, query)
}

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
c(filtragem_de_movimentacoes(con_arquivos,"cagedfor202201","","","","","",""))
