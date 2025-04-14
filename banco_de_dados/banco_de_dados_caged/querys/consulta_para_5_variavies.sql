WITH filtragem AS (
    SELECT *,
        CASE
            -- Combinações de 5 variáveis
            WHEN (uf = local_ AND sexo = sexo_ AND raçacor = raca_ AND faixa_idade = idade_ AND graudeinstrução = gdi_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND raçacor = raca_ AND faixa_idade = idade_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND raçacor = raca_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND faixa_idade = idade_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND raçacor = raca_ AND faixa_idade = idade_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (sexo = sexo_ AND raçacor = raca_ AND faixa_idade = idade_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE

            -- Combinação com 6 variáveis
            WHEN (uf = local_ AND sexo = sexo_ AND raçacor = raca_ AND faixa_idade = idade_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE

            ELSE FALSE
        END AS validacao
)
SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção
FROM filtragem
WHERE validacao = TRUE;
