# Função de filtragem para todas as variáveis
library(DBI)
library(glue)

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
    SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, tipomovimentação
    FROM filtragem
    WHERE validacao = TRUE;
  ")
  
  # Executa a query no banco de dados e retorna o resultado
  dbGetQuery(conexao, query)
}
