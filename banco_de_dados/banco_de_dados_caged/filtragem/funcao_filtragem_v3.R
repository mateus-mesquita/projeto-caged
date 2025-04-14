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
SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção
FROM filtragem
WHERE validacao = TRUE;
  ")

# Executa a query no banco de dados e retorna o resultado
return(dbGetQuery(conexao, query))
}
