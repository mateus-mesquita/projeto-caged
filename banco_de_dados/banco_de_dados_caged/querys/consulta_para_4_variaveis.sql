WITH filtragem AS (
    SELECT *,
        CASE
            WHEN (uf = local_ AND sexo = sexo_ AND raçacor = raca_ AND faixa_idade = idade_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND raçacor = raca_ AND graudeinstrução = gdi_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND raçacor = raca_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND faixa_idade = idade_ AND graudeinstrução = gdi_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND faixa_idade = idade_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND sexo = sexo_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND raçacor = raca_ AND faixa_idade = idade_ AND graudeinstrução = gdi_) THEN TRUE
            WHEN (uf = local_ AND raçacor = raca_ AND faixa_idade = idade_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND raçacor = raca_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (uf = local_ AND faixa_idade = idade_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (sexo = sexo_ AND raçacor = raca_ AND faixa_idade = idade_ AND graudeinstrução = gdi_) THEN TRUE
            WHEN (sexo = sexo_ AND raçacor = raca_ AND faixa_idade = idade_ AND seção = setor_) THEN TRUE
            WHEN (sexo = sexo_ AND raçacor = raca_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (sexo = sexo_ AND faixa_idade = idade_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE
            WHEN (raçacor = raca_ AND faixa_idade = idade_ AND graudeinstrução = gdi_ AND seção = setor_) THEN TRUE

            ELSE FALSE
        END AS validacao
)
SELECT uf, sexo, raçacor, faixa_idade, graudeinstrução, seção
FROM filtragem
WHERE validacao = TRUE;
