# Funções de filtragem

filtragem_2V <- function(tabela, local_, sexo_, raca_, idade_, gdi_, setor_) {
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
SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção, tipomovimentação
FROM filtragem
WHERE validacao = TRUE;
"
  )
  
  return(dbGetQuery(con, query))
}


