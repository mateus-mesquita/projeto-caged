# Função de filtragem para uma variável

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

SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, tipomovimentação 
FROM filtragem
WHERE validacao = TRUE;
  ")

# Executa a query no banco de dados e retorna o resultado
return(dbGetQuery(conexao, query))
}

